require 'rails_helper'

RSpec.feature "Customers", type: :feature, js: true do
  scenario 'Verify register client link' do
    visit(root_path)

    expect(page).to have_link('Cadastro de Clientes')
  end

  scenario 'Verify new client button' do
    visit(root_path)
    click_on('Cadastro de Clientes')

    expect(page).to have_link('Novo Cliente')
  end

  scenario 'Verify new client form' do
    visit(customers_path)
    click_on('Novo Cliente')

    expect(page).to have_content('Novo Cliente')
  end

  scenario 'Register a valid client' do
    visit(new_customer_path)

    customer_name = Faker::Name.name
    fill_in('customer_name', with: customer_name)
    fill_in('customer_email', with: Faker::Internet.email)
    fill_in('customer_phone', with: Faker::PhoneNumber.phone_number)
    attach_file('customer_avatar', "#{Rails.root}/spec/fixtures/avatar.png")
    select('Sim', from: 'customer_smoker')

    click_on('Criar Cliente')

    expect(page).to have_content('Cliente cadastrado com sucesso!')
    expect(Customer.last.name).to eq(customer_name)
  end

  scenario 'Try to register a invalid client' do
    visit(new_customer_path)

    click_on('Criar Cliente')

    expect(page).to have_content("não pode ficar em branco")
  end

  scenario 'Show a client' do
    customer = create(:customer)

    visit(customer_path(customer.id))

    expect(page).to have_content(customer.name)
  end

  scenario 'Show a list of clients' do
    customer1 = create(:customer)
    customer2 = create(:customer)

    visit(customers_path)

    expect(page).to have_content(customer1.name).and have_content(customer2.name)
  end

  scenario 'Update a client' do
    customer = create(:customer)
    new_name = Faker::Name.name

    visit(edit_customer_path(customer.id))

    fill_in('customer_name', with: new_name)
    click_on('Atualizar Cliente')

    expect(page).to have_content('Cliente atualizado com sucesso!')
    expect(page).to have_content(new_name)
  end

  scenario 'click show button on index' do
    create(:customer)

    visit(customers_path)

    find(:xpath, '/html/body/table/tbody/tr[1]/td[5]/a').click
    expect(page).to have_content('Mostrando Cliente')
  end

  scenario 'click edit button on index' do
    create(:customer)

    visit(customers_path)

    find(:xpath, '/html/body/table/tbody/tr[1]/td[6]/a').click
    expect(page).to have_content('Editando Cliente')
  end

  scenario 'click delete button on index' do
    create(:customer)

    visit(customers_path)

    find(:xpath, '/html/body/table/tbody/tr[1]/td[7]/a').click
    page.driver.browser.switch_to.alert.accept

    expect(page).to have_content('Cliente apagado com sucesso!')
  end
end
