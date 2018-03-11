require "spec_helper"

describe Api::V1::VotesController, type: :controller do

  let!(:law_project) {create :law_project}
  let!(:authorization) {create :authorization, cpf: '02589041780', address: '39a008712649c0a7b2fcbb8310249f6a794b34cd'}
  let(:parsed_response) { JSON.parse(@response.body) }

  describe "#create" do
    before do
      @params = {
        vote: {
          law_project_id: law_project.id,
          vote_choice: true,
          comment: "concordo com o texto todo",
          signed_message: "{r:'aaa',s:'bbb',v:'ccc'}",
          address: "39a008712649c0a7b2fcbb8310249f6a794b34cd"
        }
      }
    end

    context "quando o usuario gostaria de votar" do
      context "e passa todos os dados corretamente" do
        it "deve criar um voto" do
          post :create, params: @params
          expect(response).to be_success
          expect(Vote.count).to eq 1
          expect(Vote.first.vote_choice).to eq true
          expect(Vote.first.law_project.id).to eq law_project.id
        end
      end

      context "e passa todos os dados corretamente, porém com um endereço não autorizado" do
        before do
          Authorization.destroy_all
        end
        it "deve criar um voto" do
          post :create, params: @params
          expect(response).to_not be_success
          expect(Vote.count).to eq 0
          expect(parsed_response["msg"].first).to eq "Address Endereço não autorizado a votar"
        end
      end
    end



    context "e passa todos os dados incorretamente faltando 1 param obrigatório" do
      before do
        @params = {
          vote: {
            law_project_id: law_project.id,
            vote_choice: true,
            comment: "concordo com o texto todo",
            signed_message: "{r:'aaa',s:'bbb',v:'ccc'}"
          }
        }
      end
      it "não deve criar uma autorização" do
        post :create, params: @params
        expect(response).to_not be_success
        expect(Vote.count).to eq 0
        expect(parsed_response["msg"].first).to eq "Address O campo endereço é obrigatório"
      end
    end
  end
end