require 'test_helper'
require 'investment_tracking_domain/application/create_investor'

class CreateInvestorTest < MiniTest::Test
  def test_it_creates_an_investor
    listener.expect :investor_created, nil, ['created investor']
    investor_class.expect(
      :new,
      'created investor',
      [{
        name: valid_investor_params[:name],
        repository: investor_repository
      }]
    )
    operation = Application::CreateInvestor.new(operation_params)

    operation.create_investor(valid_investor_params)

    investor_repository.verify
    listener.verify
  end

  private

  def valid_investor_params
    {
      name: 'Investor Name'
    }
  end

  def investor_class
    @investor_class ||= MiniTest::Mock.new
  end

  def investor_repository
    @investor_repository ||= MiniTest::Mock.new
  end

  def listener
    @listener ||= MiniTest::Mock.new
  end

  def operation_params(override = {})
    {
      investor_class: investor_class,
      investor_repository: investor_repository,
      listener: listener
    }.merge(override)
  end
end
