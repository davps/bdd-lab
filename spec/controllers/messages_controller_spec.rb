require 'spec_helper'

describe MessagesController do
  login_user

  def valid_attributes
    {}
  end

  def current_user
    @current_user
  end

  describe "GET index" do
    it "assigns all messages as @messages" do
      message = FactoryGirl.create(:message, user: current_user)
      get :index
      assigns(:messages).should eq([message])
    end
  end

  describe "GET show" do
    it "assigns the requested message as @message" do
      message = FactoryGirl.create(:message, user: current_user)
      get :show, {:id => message.to_param}
      assigns(:message).should eq(message)
    end
  end

  describe "GET new" do
    it "assigns a new message as @message" do
      get :new, {}
      assigns(:message).should be_a_new(Message)
    end
  end

  describe "GET edit" do
    it "assigns the requested message as @message" do
      message = FactoryGirl.create(:message, user: current_user)
      get :edit, {:id => message.to_param}
      assigns(:message).should eq(message)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Message" do
        expect {
          new_message = FactoryGirl.build(:message, user: current_user)
          post :create, {:message => new_message}
        }.to change(Message, :count).by(1)
      end

      it "assigns a newly created message as @message" do
        new_message = FactoryGirl.build(:message, user: current_user)
        post :create, {:message => new_message}
        assigns(:message).should be_a(Message)
        assigns(:message).should be_persisted
      end

      it "redirects to the created message" do
        new_message = FactoryGirl.build(:message, user: current_user)
        post :create, {:message => new_message}
        response.should redirect_to(Message.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved message as @message" do
        # Trigger the behavior that occurs when invalid params are submitted
        Message.any_instance.stub(:save).and_return(false)
        post :create, {:message => {}}
        assigns(:message).should be_a_new(Message)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Message.any_instance.stub(:save).and_return(false)
        post :create, {:message => {}}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested message" do
        message = FactoryGirl.create(:message, user: current_user)
        # Assuming there are no other messages in the database, this
        # specifies that the Message created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Message.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => message.to_param, :message => {'these' => 'params'}}
      end

      it "assigns the requested message as @message" do
        message = FactoryGirl.create(:message, user: current_user)
        put :update, {:id => message.to_param, :message => valid_attributes}
        assigns(:message).should eq(message)
      end

      it "redirects to the message" do
        message = FactoryGirl.create(:message, user: current_user)
        put :update, {:id => message.to_param, :message => valid_attributes}
        response.should redirect_to(message)
      end
    end

    describe "with invalid params" do
      it "assigns the message as @message" do
        message = FactoryGirl.create(:message, user: current_user)
        # Trigger the behavior that occurs when invalid params are submitted
        Message.any_instance.stub(:save).and_return(false)
        put :update, {:id => message.to_param, :message => {}}
        assigns(:message).should eq(message)
      end

      it "re-renders the 'edit' template" do
        message = FactoryGirl.create(:message, user: current_user)
        # Trigger the behavior that occurs when invalid params are submitted
        Message.any_instance.stub(:save).and_return(false)
        put :update, {:id => message.to_param, :message => {}}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested message" do
      message = FactoryGirl.create(:message, user: current_user)
      expect {
        delete :destroy, {:id => message.to_param}
      }.to change(Message, :count).by(-1)
    end

    it "redirects to the messages list" do
      message = FactoryGirl.create(:message, user: current_user)
      delete :destroy, {:id => message.to_param}
      response.should redirect_to(messages_url)
    end
  end

end
