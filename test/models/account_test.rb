require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test 'should have name' do
    refute accounts(:no_name).valid?
  end

  test 'should have subdomain' do
    refute accounts(:no_subdomain).valid?
  end

  test 'should have properly formatted subdomain' do
    refute accounts(:two_alpha_subdomain).valid?
    refute accounts(:all_dashes_subdomain).valid?
    refute accounts(:ending_dash_subdomain).valid?
    refute accounts(:starting_dash_subdomain).valid?
    refute accounts(:starting_numeric_subdomain).valid?
    assert accounts(:ending_numeric_subdomain).valid?
    assert accounts(:three_alpha_subdomain).valid?
    assert accounts(:dash_separated_subdomain).valid?
  end

  test 'should have unique subdomain' do
    account1 = accounts(:dash_separated_subdomain)
    account2 = Account.new(name: "Duplicated Subdomain", subdomain: accounts(:dash_separated_subdomain).subdomain)
    refute account2.save, "Saved an account with the same subdomain"
  end
end
