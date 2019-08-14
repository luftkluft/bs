RSpec.describe CartPolicy, type: :policy do
  let!(:user) { create(:user, password: 'password1', email: 'user1@example.com') }
  let!(:cart) { create_list(:cart, 1, user_id: user.id) }
  let!(:user2) { create(:user, id: user.id + 1, password: 'password2', email: 'user2@example.com') }
  let!(:second_cart) { create_list(:cart, 1, user_id: user.id + 1) }

  subject { described_class }

  permissions :index?, :show?, :create?, :new?, :update?, :edit?, :destroy?, :add_item?, :delete_item?,
              :incrememt_quantity?, :decrememt_quantity?, :checkout? do
    it 'denies access if user not owner' do
      expect(subject).not_to permit(user, second_cart.last)
    end

    it 'grants access if user is owner' do
      expect(subject).to permit(user, cart.last)
    end
  end
end