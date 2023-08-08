class MessageDecorator < Draper::Decorator
  delegate_all

  def full_desc
    [
      object.name,
      object.email,
      object.phone
    ].compact.join(' | ')
  end
end
