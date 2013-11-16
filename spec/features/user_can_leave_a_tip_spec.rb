require 'spec_helper'

describe 'A user', js: true  do
  it 'can make a donation' do
    with_feature_active :payments do
      cosmo = create(:drink, name: 'cosmo', glass: nil)

      visit root_path

      fill_in 'user-input', with: 'cosmo'

      click_button 'Make my Drink!'

      click_on 'Thanks, bartendr!'

      Stripe.api_key = ENV['SECRET_KEY']
      Stripe::Charge.stub!(:create)

      expect(page).to have_content 'Tips welcome'

      fill_in 'Contribution (USD)', with: '10'
      fill_in 'Card Number', with: '4242 4242 4242 4242'
      fill_in 'CVC', with: '767'
      fill_in 'month', with: '07'
      fill_in 'year', with: '2017'

      click_button 'submit'

      expect(page).to have_content 'success'
    end
  end
end
