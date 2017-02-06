class Object
  def to_imap_date
    date = respond_to?(:utc) ? utc.to_s : to_s
    Date.parse(date).strftime('%d-%b-%Y')
  end
end
class Account < ApplicationRecord
  has_many :letters

  def create_letters(gmail,startDate,endDate)
    current_date = Time.now
    gmail.inbox.emails( :after => startDate,:before => endDate).each do |email|
      letters.create(text:email.text_part.decoded, date: email.date, is_read: email.read?, files_count:email.attachments.count, timestamp: current_date)
    end
    gmail.logout

# без подключения к gmail
#  letters.create(text:"письмо1", date: Time.new(2017, 01, 24), is_read: false, files_count:0, timestamp: current_date)
#  letters.create(text:"письмо2", date: Time.new(2017, 01, 25), is_read: true, files_count:1, timestamp: current_date)
#  letters.create(text:"письмо3", date: Time.new(2017, 01, 25), is_read: true, files_count:3, timestamp: current_date)
#  letters.create(text:"письмо4", date: Time.new(2017, 01, 25), is_read: false, files_count:5, timestamp: current_date)
#  letters.create(text:"письмо5", date: Time.new(2017, 01, 27), is_read: true, files_count:0, timestamp: current_date)
#  letters.create(text:"письмо6", date: Time.new(2017, 01, 29), is_read: true, files_count:5, timestamp: current_date)
#  letters.create(text:"письмо7", date: Time.new(2017, 01, 30), is_read: true, files_count:10, timestamp: current_date)
#  letters.create(text:"письмо8", date: Time.new(2017, 01, 30), is_read: true, files_count:5, timestamp: current_date)

  end

end
