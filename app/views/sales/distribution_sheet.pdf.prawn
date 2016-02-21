prawn_document do |pdf|
  pdf.image Rails.root.join('app','assets','images','logo.png')
  pdf.font_size 20
  pdf.text_box "Commission Distribution Sheet", at: [pdf.bounds.left, pdf.bounds.top], align: :right, width: pdf.bounds.width
  
  pdf.font_size 12
  pdf.text_box "FILE NUMBER: #{@sale.code}", at: [pdf.bounds.left, pdf.bounds.top - 30], align: :right, width: pdf.bounds.width
  
  pdf.move_down 50
  
  pdf.font_size 9
  pdf.bounding_box [pdf.bounds.left, pdf.bounds.top - 70], width: pdf.bounds.width/2-10, height: 150 do
    pdf.table [
      ['Property', @sale.property.name],
      ['Date of Contract', @sale.contract_start_on],
      ['Registration Date', @sale.registered_on],
      ['Seller', @sale.property.owner.name],
      ['Buyer', @sale.buyer&.name],    
      ['Purchase Price', number_to_currency(@sale.purchase_price)]
    ], width: pdf.bounds.width
  end
  
  pdf.bounding_box [pdf.bounds.width/2 + 10, pdf.bounds.top - 70], width: pdf.bounds.width/2 - 10, height: 150 do
    pdf.table [
      ['Transferring Attorney', @sale.attorney&.name],
      ['Bond Attorney', @sale.bond_attorney&.name],
      ['Bond Originator', @sale.originator&.name],
      ['Bond Grant', "#{number_to_currency(@sale.grant_amount)} #{@sale.bank&.name}"]
    ], width: pdf.bounds.width
  end
  
  pdf.table [
    ['Total Commission Incl VAT', number_to_currency(@sale.commission)],
    ['VAT', number_to_currency(@sale.vat)],
    ['Nett Commission', number_to_currency(@sale.commission - @sale.vat)]      
  ], width: pdf.bounds.width, column_widths: { 1 => 100} do |t|
    t.columns(1).style align: :right
  end
  
  @sale.commissions.each do |commission|
    pdf.move_down 20
    commdata = [
      [commission.agent.name, ''],
      ["Commission @ #{commission.commission_percent} %", number_to_currency(commission.gross_amount)],
      ["PAYE @ #{commission.tax_percent} %", number_to_currency(commission.total_tax * -1)]
    ]
    
    commission.deductions.each do |deduction|
      commdata << [deduction.deductable.name, number_to_currency(deduction.amount * -1)]
    end
    
    commdata << ['Total To Agent:', number_to_currency(commission.total_payable)]
    pdf.table commdata, width: pdf.bounds.width, column_widths: { 1 => 100} do |t|
      t.columns(1).style align: :right
      t.rows(0).style background_color: 'AFAFAF', font_style: :bold
      t.rows(commission.deductions.count + 3).style background_color: 'EFEFEF', font_style: :bold
    end
  end
  
  pdf.move_down 50
  pdf.text "PAID ON: ___________________________"
  
  pdf.move_down 50
  pdf.text "SIGNATURE: ___________________________"
  
end