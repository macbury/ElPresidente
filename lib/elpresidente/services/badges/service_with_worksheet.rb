module Badges
  class ServiceWithWorksheet < Service
    def session
      @session ||= GoogleDrive::Session.from_service_account_key("#{__dir__}/../../../../google.json")
    end

    def worksheet
      @worksheet ||= session.spreadsheet_by_key(ENV.fetch('TOP_BOARD_ID')).worksheets[0]
    end
  end
end