class Agent
  constructor: (elem) ->
    console.log "New agent"
    @commissionPercentField = elem.find('[data-behavior=commission_percent]')
    @taxPercentField = elem.find('[data-behavior=tax_percent]')
    @grossAmountField = elem.find('[data-behavior=gross_amount]')
    @totalTaxField = elem.find('[data-behavior=total_tax]')
    @nettAmountField = elem.find('[data-behavior=nett_amount]')

  recalculate: (totalCommission) ->
    console.log this
    commissionPercent = parseFloat(@commissionPercentField.prev('input').val()).toFixed(2)
    taxPercent = parseFloat(@taxPercentField.prev('input').val()).toFixed(2)
    
    grossAmount = (totalCommission * commissionPercent / 100.0).toFixed(2)
    totalTax = (grossAmount * taxPercent / 100.0).toFixed(2)
    nettAmount = (grossAmount - totalTax).toFixed(2)
    
    @grossAmountField.html(grossAmount)
    @grossAmountField.prev('input').val(grossAmount)
    
    @totalTaxField.html(totalTax)
    @totalTaxField.prev('input').val(totalTax)
    
    @nettAmountField.html(nettAmount)
    @nettAmountField.prev('input').val(nettAmount)    

class Sale
  constructor: (elem) ->
    console.log "New sale"
    @commissionField = elem.find('[data-behavior=commission]')
    console.log @commissionField
    @vatField = elem.find('[data-behavior=vat]')    
    @nettField = elem.find('[data-behavior=nett]')    
    @agents = []
    for a in elem.find('[data-behavior=agent]')
      @agents.push(new Agent($(a)))     
    me = this
    @commissionField.on 'keyup', ->
      me.recalculate()
  
  recalculate: ->
    console.log this
    commission = parseFloat(@commissionField.val())
    totalCommission = (commission / 1.14).toFixed(2)
    vat = (commission - totalCommission).toFixed(2)
    @vatField.val(vat)
    @nettField.html(totalCommission)
    
    for a in @agents
      a.recalculate(totalCommission)

jQuery(document).on 'ready page:load', ->  
  console.log "Loaded...."
  if $('[data-behavior=sale]').length > 0
    console.log "Found something"
    sale = new Sale($('[data-behavior=sale]'))