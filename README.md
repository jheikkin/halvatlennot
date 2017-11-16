# halvatlennot

Initial version to search cheap flights for given dates from halvatlennot.fi search engine

Requires: Python 2.x, Selenium and RobotFramework

Execute test run:

	git clone https://github.com/jheikkin/halvatlennot
	cd robotframework
	python -m robot.run pybot.robot


Execute test run with specific dates:

	python -m robot.run --variable DepartureDate:1 --variable DepartureMonth:2018-7 --variable ReturnDate:1 --variable ReturnMonth:2018-8 pybot.robot

Execute test run with specific dates for 3 following dates (including the beginning):

	python -m robot.run --variable DepartureDate:1 --variable DepartureMonth:2018-7 --variable ReturnDate:1 --variable ReturnMonth:2018-8 
		--variable Rounds:3 pybot.robot
