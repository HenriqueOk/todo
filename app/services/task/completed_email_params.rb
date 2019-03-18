class Task::CompletedEmailParams
  MESSAGES = [
    'YOU ARE AWESOME!',
    'KEEP IT UP!',
    'YOU DID IT!',
    'YOU WIN! PERFECT!',
    'VICTORY!',
  ].freeze
  MESSAGE_COLORS = [
    '#0000FF',
    '#00FF00',
    '#FF0000',
    '#0F0F0F',
    '#F0F0F0',
  ].freeze

  def self.call
    OpenStruct.new(
      message: MESSAGES.sample,
      message_color: MESSAGE_COLORS.sample
    )
  end
end
