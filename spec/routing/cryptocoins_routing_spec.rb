require "rails_helper"

RSpec.describe CryptocoinsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/cryptocoins").to route_to("cryptocoins#index")
    end

    it "routes to #new" do
      expect(get: "/cryptocoins/new").to route_to("cryptocoins#new")
    end

    it "routes to #show" do
      expect(get: "/cryptocoins/1").to route_to("cryptocoins#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/cryptocoins/1/edit").to route_to("cryptocoins#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/cryptocoins").to route_to("cryptocoins#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/cryptocoins/1").to route_to("cryptocoins#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/cryptocoins/1").to route_to("cryptocoins#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/cryptocoins/1").to route_to("cryptocoins#destroy", id: "1")
    end
  end
end
