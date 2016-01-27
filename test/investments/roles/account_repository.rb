module AccountRepository
  def it_responds_to_create_account
    assert_respond_to account_repository, :create_account
  end
end
