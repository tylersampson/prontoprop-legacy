class Rental < ActiveRecord::Base
  has_paper_trail

  belongs_to :lease
  has_many :commissions, as: :commissionable

  before_save :calculate_commissions

  def description
    "RENTAL (#{lease.managed? ? 'Managed' : 'Unmanaged'}) - #{lease.property.name}"
  end

  def self.import(file)
    total_imported = 0
    CSV.foreach(file.path, headers: true) do |row|
      if row['BeneficiaryType'] == 'Commission'
        lease = Lease.joins(:property, :status).where('statuses.category = ? AND properties.external_id = ?', 'Active', row['PropertyID']).first
        if lease.present?
          rental = find_by_import_id(row['PaymentRecordID']) || new
          rental.lease = lease
          rental.amount_received = row['PaidAmount'].to_f
          rental.date_received = Date.strptime(row['ReconDate'], '%m/%d/%Y')
          rental.commission = row['AfterSplitAmount'].to_f
          rental.vat = row['AfterSplitAmountVAT'].to_f
          rental.fees = row['ServiceFee'].to_f
          rental.import_id ||= row['PaymentRecordID']
          rental.code ||= row['PaymentRecordID']
          rental.save!
          total_imported += 1
        end
      end
    end
    total_imported
  end

  protected

  def calculate_commissions
    commissions.destroy_all
    nett_commission = self.commission - self.vat - self.fees

    self.lease.property.agent_properties.each do |ap|
      agent_gross = (nett_commission * ap.commission_percent / 100.0).round(2)
      agent_tax = (agent_gross * ap.agent.tax / 100.0).round(2)
      agent_nett = agent_gross - agent_tax

      self.commissions.build(
        agent_id: ap.agent_id,
        commission_percent: ap.commission_percent,
        gross_amount: agent_gross,
        tax_percent: ap.agent.tax,
        total_tax: agent_tax,
        nett_amount: agent_nett
      )
    end
  end
end
