prawn_document do |pdf|
  pdf.image Rails.root.join('app','assets','images','logo.png')
  pdf.font_size 20
  pdf.text_box "Commission Statement", at: [pdf.bounds.left, pdf.bounds.top], align: :right, width: pdf.bounds.width
  
  pdf.font_size 12
  pdf.text_box "FILE NUMBER: #{@agent.code}", at: [pdf.bounds.left, pdf.bounds.top - 30], align: :right, width: pdf.bounds.width
    
  pdf.text_box "AGENT: #{@agent.name}", at: [pdf.bounds.left, pdf.bounds.top - 50], align: :right, width: pdf.bounds.width
  
  pdf.text_box "DATE: #{Date.today}", at: [pdf.bounds.left, pdf.bounds.top - 70], align: :right, width: pdf.bounds.width
  
  data = [['Code', 'Description', 'Debit', 'Credit', 'Balance']]
  balance = 0.0
  total_rows = 1
  @commissions.where(paid_on: nil).collect do |commission|
    balance += commission.gross_amount
    data << [      
      commission.commissionable.code,
      commission.commissionable.description,
      "",
      number_to_currency(commission.gross_amount),
      number_to_currency(balance),
    ]
    
    balance -= commission.total_tax
    data << [      
      "","PAYE",
      number_to_currency(commission.total_tax),
      "",
      number_to_currency(balance),
    ]
    total_rows += 2
    
    commission.deductions.each do |deduction|      
      balance -= deduction.amount
      data << [      
        "",deduction.deductable.name,
        number_to_currency(deduction.amount),
        "",
        number_to_currency(balance),
      ]
      total_rows += 1
    end    
  end
  data << ["","Total Commission Payable:","","",number_to_currency(balance)]
  
  pdf.move_down 100
  pdf.font_size 9
  pdf.table data, width: pdf.bounds.width, column_widths: { 0 => 60, 2 => 80, 3 => 80, 4 => 80} do |t|
    t.rows(0).style background_color: 'AFAFAF', font_style: :bold
    t.rows(total_rows).style background_color: 'AFAFAF', font_style: :bold
  end
 
  pdf.move_down 50
  pdf.text "PRINCIPLE SIGNATURE: ___________________________"
  
  pdf.move_down 50
  pdf.text "DATE: ___________________________"
  
  pdf.move_down 50
  pdf.text "AGENT SIGNATURE: ___________________________"
  
end