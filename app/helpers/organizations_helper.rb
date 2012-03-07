module OrganizationsHelper

  # For phones on contacts - removes a phone field and deletes the phone object
  def remove_link_unless_new_record(fields)
    unless fields.object.new_record?
      out = ''
      out << fields.hidden_field(:_destroy)
      out << link_to_function("remove", "$(this).up('.#{fields.object.class.name.underscore}').hide(); $(this).previous().value = '1'")
      out
    end
  end

  # For phones on contacts - adds a link which adds another phone field
  def add_phone_link(name, form)
    link_to_function name do |page|
      phone = render(:partial => 'phone', :locals => { :person_form => form, :phone => Phone.new })
      page << %{
        var new_phone_id = "new_" + new Date().getTime();
        $('phones').insert({ bottom: "#{ escape_javascript phone }".replace(/NEW_RECORD/g, new_phone_id) });
      }
    end
  end
end
