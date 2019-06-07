## TechTest by David Stothers

#Instructions for use:
- Open app
- Click "Get list of authorities" to query the api for the full list of authorities.
- Status text will appear showing "Loading authorities data" while the request is ongoing (should be very fast) and "Got Authorities data" when the request is complete
- A picker will appear with a list of authorities in alphabetical order, and a "Get Breakdown" button
- Select an authority and click "Get Breakdown"
- Status will update to indicate the authority being requested. This request usually takes much longer.
- When complete a table will appear with a breakdown in percentages beside it. These are sorted numerically/alphabetically, and will only show those relevant to the scheme the authority is subscribed to (Numeric/TextBased)

#Assumptions (Some further assumptions may be in the code):
- Drop down's don't exist in iOS so a picker was used instead
- UI has been written to be functional but could be significantly improved with more storyboarding and a more dynamic table, with 2 columns. I haven't worked much in UI before so presented the data as best I could. Similarly, I haven't written XCTest UI tests before, and would prefer to use Appium to functionally test the app.
- Networking has not been tested however network mocks should be added such that its not testing with live data. Again, this is due to not having enough experience mocking network calls.
- API is http rather than https, and is therefore not very safe. The owners of the api should be contacted to make the api more secure
- There is no indicator other than the data itself that a field is optional, so some fields have been assumed to be optional based on the data.
- The data itself contained more results than the requirements suggested. All the possible results have all been shown, rather than assuming some data wasn't wanted.
