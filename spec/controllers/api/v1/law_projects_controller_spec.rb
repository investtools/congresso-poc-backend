require "spec_helper"

describe Api::V1::LawProjectsController, type: :controller do

  let!(:law_project) {create :law_project, title: "teste1"}
  let!(:law_project2) {create :law_project, title: "teste2"}
  let!(:law_project3) {create :law_project, title: "teste3"}
  let(:parsed_response) { JSON.parse(@response.body) }

  describe "#index" do
    
    context "quando o usuario gostaria de listar todos os projetos de lei" do
      context "e passa todos os dados corretamente" do
        it "deve listar todos os projetos de lei" do
          get :index
          expect(response).to be_success
          expect(parsed_response.first["title"]).to eq "teste1"
        end
      end
    end

  end
end