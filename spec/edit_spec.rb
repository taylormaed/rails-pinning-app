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
      expect(response.success?).to be(true)
      end

      it 'assigns an instance variable called @pin to the pin with the appropriate id' do
      get :edit, id: @pin.id
      expect(response.success?).to be(true)
    end
  end
