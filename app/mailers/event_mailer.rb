class EventMailer < ApplicationMailer

  def subscription(event, subscription)
    @email = subscription.user_email
    @name = subscription.user_name
    @event = event

    mail to: event.user.email, subject: "Новая подписка на #{event.title}"
  end

  def comment(event, commet, email)
    @comment = commet
    @event = event

    mail to: email , subject: "Новый комментарий #{event.title}"
  end
end
