class RatesController < BaseController
  def index
    user_id = params[:user_id]
    @user = User.find_by_id(user_id)
    #@rates = Rate.find(:all, :joins=>"left join contracts on contracts.id=rates.rateable_id",:conditions=>['(contracts.user_id=? or contracts.contractor_id=?) and rater_id!=? and rateable_type="Contract" and active = true',user_id,user_id,user_id],:order=>'contracts.end_datetime desc')
    @contracts = Contract.find(:all, :conditions=>['(contracts.user_id=? or contracts.contractor_id=?) and end_datetime is not null', user_id, user_id])
  end
end
