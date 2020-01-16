require 'rails_helper'

RSpec.describe Article, :type => :model do
  let(:user) { User.create(password: "password", email: "jo@yes.com") }
  let(:category) { Category.create(name: "Buy", description: "To buy smthing") }
  subject { described_class.new(user_id: user.id, category_id: category.id) }
  
  it { should belong_to(:user) }
  it { should belong_to(:category) }

  it "is valid with valid attributes" do
    subject.title = "Anything"
    subject.text = "Smthing more"
    expect(subject).to be_valid
  end

  it "is not valid without a title" do
    expect(subject).to_not be_valid
  end

  it "is not valid without a text" do
    subject.title = "Anything"
    expect(subject).to_not be_valid
  end
end
