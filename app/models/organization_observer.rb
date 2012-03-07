class OrganizationObserver < ActiveRecord::Observer

  def after_create(org)
    summary = "Organization Created - #{org.name}"
    description = ""

    # uses the association to create an Activity
    org.activities.create(:summary => summary, :description => description)
  end

  def after_update(org)
    phones_msg = ""

    # determine message for changes to phones
    if org.phones_changes.present?
      all_phone_msgs = {}
      org.phones_changes.each do |ph_key, ph_change|
        msg = {}
        ph_change.each do |k,v|
          msg[k] = "#{k} changed from \"#{v[0]}\" to \"#{v[1]}\""
        end
        all_phone_msgs[ph_key] = msg.values.to_sentence
      end
      phones_msg = all_phone_msgs.values.join("\r\n")
    end

    # determine message for additions to phones
    if org.phones_added.present?
      all_phones_added_msgs = []
      for phone in org.phones_added
        type = phone.phone_type.blank? ? "" : phone.phone_type.name
        all_phones_added_msgs << "#{type} phone added: #{phone.full_number}"
      end
      phone_added_msg = all_phones_added_msgs.join("\r\n")
      phones_msg << (phones_msg.blank? ? phone_added_msg : "\r\n#{phone_added_msg}") 
    end

    # create a sentence with each of the relevant changes stated.
    record_changes = []
    relevant_changed_columns = org.changed.reject{|attr| ["created_at", "updated_at"].include?(attr)}
    relevant_changed_columns.each{|attr| record_changes << "#{attr} changed from \"#{org.changes[attr].first}\" to \"#{org.changes[attr].last}\""}
    all_relevant_changed_attributes = relevant_changed_columns
    all_relevant_changed_attributes << "phones" if org.phones_changes.present? || org.phones_added.present?

    summary = "Organization Updated - #{org.name}: #{all_relevant_changed_attributes.to_sentence} changed"
    description = record_changes.to_sentence
    description += "\r\n\r\nPhones:\r\n" + phones_msg unless phones_msg.blank?

    # uses the association to create an Activity
    org.activities.create(:summary => summary, :description => description)
  end
end
