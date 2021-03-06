require 'spec_helper'
RSpec.describe PinsController do
        
    describe "GET index" do
        
        it 'renders the index template' do
        get :index
        expect(response).to render_template("index")
      end
        
        it 'populates @pins with all pins' do
            get :index
            expect(assigns[:pins]).to eq(Pin.all)
        end
    end

    describe "GET new" do
    it 'responds with successfully' do
      get :new
      expect(response.success?).to be(true)
    end
    
    it 'renders the new view' do
      get :new      
      expect(response).to render_template(:new)
    end
    
    it 'assigns an instance variable to a new pin' do
      get :new
      expect(assigns(:pin)).to be_a_new(Pin)
    end
  end
  
  describe "POST create" do
    before(:each) do
      @pin_hash = { 
        title: "Rails Wizard", 
        url: "http://railswizard.org", 
        slug: "rails-wizard", 
        text: "A fun and helpful Rails Resource",
        category_id: "rails"}
    end
    
    after(:each) do
      pin = Pin.find_by_slug("rails-wizard")
      if !pin.nil?
        pin.destroy
      end
    end
    
      it 'responds with a redirect' do
        post :create, pin: @pin_hash
        expect(response.redirect?).to be(true)
      end
    
      it 'creates a pin' do
        post :create, pin: @pin_hash  
        expect(Pin.find_by_slug("rails-wizard").present?).to be(true)
      end
    
      it 'redirects to the show view' do
        post :create, pin: @pin_hash
        expect(response).to redirect_to(pin_url(assigns(:pin)))
      end
    
      it 'redisplays new form on error' do
      # The title is required in the Pin model, so we'll
      # delete the title from the @pin_hash in order
      # to test what happens with invalid parameters
        @pin_hash.delete(:title)
        post :create, pin: @pin_hash
        expect(response).to render_template(:new)
      end
    
      it 'assigns the @errors instance variable on error' do
      # The title is required in the Pin model, so we'll
      # delete the title from the @pin_hash in order
      # to test what happens with invalid parameters
        @pin_hash.delete(:title)
        post :create, pin: @pin_hash
        expect(assigns[:errors].present?).to be(true)
      end    
  
  describe "GET edit" do
    before(:each) do
      @pin = Pin.find(3)
    end

      it 'responds successfully' do
      get :edit, id: @pin.id
      expect(response.success?).to be(true)
      end

      it 'renders the edit template' do
      get :edit, id: @pin.id
      expect(response).to render_template(:edit)
      end

      it 'assigns an instance variable called @pin to the pin with the appropriate id' do
      get :edit, id: @pin.id
      expect(assigns(:pin)).to eq(@pin)
      end
    end
  end 

  describe "POST update" do
    before (:each) do
      @pin  = Pin.find(2)
      @pin_hash = {
        title: 'Rails for Zombies', 
        url: 'http://railsforzombies.org', 
        text: "A fun, gamified way to hone your Rails skills! Come on...who doesn't like fighting zombies?!", 
        slug: "rails-for-zombies",
        category_id: "rails"
      }
      
      @error_hash = {
        title: nil,
        category_id: nil,
        url: nil,
        text: 8,
        slug: nil 
      }
    end

      context "request to /pins with valid parameters" do
        it 'responds with success' do
          put :update, id: @pin.id, pin: @pin_hash
          expect(response).to redirect_to("/pins/#{@pin.id}")
        end

        it 'updates a pin' do
          put :update, id: @pin.id, pin: @pin_hash
          expect(Pin.find(@pin.id).title).to eq(@pin_hash[:title])
        end

        it 'redirects to the show view' do
          put :update, id: @pin.id, pin: @pin_hash
          expect(response).to redirect_to(pin_url(assigns(:pin)))
        end
      end

      context "request to /pins with invalid parameters" do
        it 'assigns an @errors instance variable' do
            put :update, id: @pin.id, pin: @error_hash
            expect(assigns[:errors].present?).to be(true)
        end

        it 'renders the edit view' do
          put :update, id: @pin.id, pin: @error_hash
          expect(response).to render_template(:edit)
        end
      end
  end
end