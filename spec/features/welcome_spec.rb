require 'rails_helper'

RSpec.feature "Welcomes", type: :feature do
  scenario 'Mostra mensagem de Bem-Vindo' do
    visit(root_path)

    expect(page).to have_content('Bem-Vindo')
  end

  scenario 'Mostra botão para criar cliente' do
    visit(root_path)

    expect(find('ul li')).to have_link('Cadastro de Clientes')
  end
end
