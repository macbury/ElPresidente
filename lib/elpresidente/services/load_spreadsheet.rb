class LoadSpreadsheet < Service
  def initialize(spreadsheet_id)
    @spreadsheet_id = spreadsheet_id
  end

  def call
    session.spreadsheet_by_key(@spreadsheet_id).worksheets[0]
  end

  private

  def session
    @session ||= GoogleDrive::Session.from_service_account_key("#{__dir__}/../../../google.json")
  end
end