class Subscription < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :event

  validates :event, presence: true
  validates :user_name, presence: true, unless: 'user.present?'
  validates :user_email, presence: true, format: /\A[a-zA-Z0-9\-_.]+@[a-zA-Z0-9\-_.]+\z/, unless: 'user.present?'
  validates :user, uniqueness: {scope: :event_id}, if: 'user.present?'
  validates :user_email, uniqueness: {scope: :event_id}, unless: 'user.present?'

  after_validation :check_dublicate_email

  def user_name
    if user.present?
      user.name
    else
      super
    end
  end

  def user_email
    if user.present?
      user.email
    else
      super
    end
  end

  def check_dublicate_email
    if User.where(email: user_email).present? || Subscription.where(user_email: user_email, event_id: event_id).present?
      errors.add :user_email, I18n.t('controllers.subscriptions.email_uniq')
    end
  end
end
