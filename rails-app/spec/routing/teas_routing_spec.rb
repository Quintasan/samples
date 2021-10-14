require "rails_helper"

RSpec.describe TeasController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/teas").to route_to("teas#index")
    end

    it "routes to #show" do
      expect(get: "/teas/1").to route_to("teas#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/teas").to route_to("teas#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/teas/1").to route_to("teas#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/teas/1").to route_to("teas#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/teas/1").to route_to("teas#destroy", id: "1")
    end
  end
end
