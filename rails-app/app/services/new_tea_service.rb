class NewTeaService < ApplicationService
  def call(params)
    params = yield validate_params(params)
    create_new_tea(
      params[:name],
      params[:country],
      params[:invalid]
    )
  end

  private

  def contract
    NewTeaContract.new
  end

  def validate_params(params)
    validation = contract.call(params)

    if validation.success?
      Success(validation.to_h)
    else
      Failure[:invalid_params, validation.errors.to_h]
    end
  end

  def create_new_tea(name, country, invalid)
    tea = Tea.new(
      name: name,
      country: country
    )

    tea.name = nil if invalid

    return Failure[:saving_failed, tea.errors] unless tea.valid?

    tea.save!
    Success(tea)
  end
end
