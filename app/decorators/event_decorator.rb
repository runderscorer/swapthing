class EventDecorator < Draper::Decorator
  include Draper::LazyHelpers
  delegate_all

  def show_assign_or_reassign
    partnerships.present? ? 'Reassign Partners' : 'Assign Partners'
  end
end