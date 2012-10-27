class CalendarEvent < Canvas
  attr_accessor :id, :title, :start_at, :end_at, :description, :location_name, :location_aaddress, :context_code, :hidden, :url, :date, :all_day, :created_at, :updated_at
end

class Appointment < Canvas
  attr_accessor :parent_event_id, :appointment_group_id, :appointment_group_url, :own_reservation, :reserve_url, :reserved, :participants_per_appointment, :available_slots, :user, :group
end

class AssignmentEvent < Canvas
  attr_accessor :assignment
end