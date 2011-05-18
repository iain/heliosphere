ar = Rails.application.config.active_record

if ar.observers
  ar.observers += [ Heliosphere::Observer ]
else
  ar.observers = [ Heliosphere::Observer ]
end
