import sys
from selenium import webdriver
import pdb
#Following are optional required
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import Select
from selenium.webdriver.chrome.options import Options
from selenium.common.exceptions import NoSuchElementException

if len(sys.argv) > 8:
	fromWhere = sys.argv[1]
	whereTo = sys.argv[2]
	departureDate = sys.argv[3]
	departureYYYYMM = sys.argv[4]
	returnDate = sys.argv[5]
	returnYYYYMM = sys.argv[6]
	numberAdults = sys.argv[7]
	numberChildren = sys.argv[8]
elif len(sys.argv) == 2:
	if sys.argv[1] != "def":
		sys.exit(2)
	else:
		fromWhere = "Helsinki"
		whereTo = "Bangkok"
		departureDate = "1"
		departureYYYYMM = "2018-7"
		returnDate = "1"
		returnYYYYMM = "2018-8"
		numberAdults = "2"
		numberChildren = "1"
else:
	print 'windows console run: chcp 65001'
	print 'usage: python halvatlennot.py "Location" "Destination" "DepartureDay" "DepartureYear-Month" "ReturnDay" "ReturnYear-Month" "# of adult passengers" "# of children passengers"'
	print 'or python halvatlennot.py def'
	sys.exit(1)

baseurl = "http://www.halvatlennot.fi"

xpaths = { 'halvatlennot-xpath1' : "//*[@id='tbAptDep']",
			'halvatlennot-xpath2' : "//*[@id='tbAptDest']",
			'halvatlennot-xpath3' : "//*[@id='ddDepartDay']",
			'halvatlennot-xpath4' : "//select[@name='ddDepartDay']",
			'halvatlennot-xpath5' : "//*[@id='ddDepartMonth']",
			'halvatlennot-xpath6' : "//select[@name='ddDepartMonth']",
			'halvatlennot-xpath7' : "//*[@id='ddReturnDay']",
			'halvatlennot-xpath8' : "//select[@name='ddReturnDay']",
			'halvatlennot-xpath9' : "//*[@id='ddReturnMonth']",
			'halvatlennot-xpath10' : "//select[@name='ddReturnMonth']",
			'halvatlennot-xpath11' : "//*[@id='ddAdults']",
			'halvatlennot-xpath12' : "//select[@name='ddAdults']",
			'halvatlennot-xpath13' : "//*[@id='ddChildren']",
			'halvatlennot-xpath14' : "//select[@name='ddChildren']",
			'halvatlennot-xpath15' : "//*[@id='btnSearch']",
			'halvatlennot-xpath16' : "//*[@id='stopsFilter']/table/tbody/tr[2]/td[1]/span",
			'halvatlennot-xpath17' : "//*[@id='stopsFilter']/table/tbody/tr[3]/td[1]/span",
			'test' : "//*[@class='smlPrice']/div"
		}

chrome_options = Options()
chrome_options.add_argument('--dns-prefetch-disable')
mydriver = webdriver.Chrome(chrome_options=chrome_options)
mydriver.get(baseurl)
mydriver.maximize_window()

#Clear Password TextBox if already allowed "Remember Me" 
#mydriver.find_element_by_xpath(xpaths['passwordTxtBox']).clear()

mydriver.find_element_by_xpath(xpaths['halvatlennot-xpath1']).send_keys(fromWhere)

mydriver.find_element_by_xpath(xpaths['halvatlennot-xpath2']).send_keys(whereTo)

# Click and select
mydriver.find_element_by_xpath(xpaths['halvatlennot-xpath3']).click()

select = Select(mydriver.find_element_by_xpath(xpaths['halvatlennot-xpath4']))
select.select_by_value(departureDate)

mydriver.find_element_by_xpath(xpaths['halvatlennot-xpath5']).click()

select = Select(mydriver.find_element_by_xpath(xpaths['halvatlennot-xpath6']))
select.select_by_value(departureYYYYMM)

mydriver.find_element_by_xpath(xpaths['halvatlennot-xpath7']).click()

select = Select(mydriver.find_element_by_xpath(xpaths['halvatlennot-xpath8']))
select.select_by_value(returnDate)

mydriver.find_element_by_xpath(xpaths['halvatlennot-xpath9']).click()

select = Select(mydriver.find_element_by_xpath(xpaths['halvatlennot-xpath10']))
select.select_by_value(returnYYYYMM)

mydriver.find_element_by_xpath(xpaths['halvatlennot-xpath11']).click()

select = Select(mydriver.find_element_by_xpath(xpaths['halvatlennot-xpath12']))
select.select_by_value(numberAdults)

mydriver.find_element_by_xpath(xpaths['halvatlennot-xpath13']).click()

select = Select(mydriver.find_element_by_xpath(xpaths['halvatlennot-xpath14']))
select.select_by_value(numberChildren)

mydriver.find_element_by_xpath(xpaths['halvatlennot-xpath15']).click()

mydriver.find_element_by_xpath(xpaths['halvatlennot-xpath16']).click()

mydriver.find_element_by_xpath(xpaths['halvatlennot-xpath17']).click()

mydriver.execute_script("window.scrollTo(0, 0)")

#pdb.set_trace()

elem = mydriver.find_element_by_xpath("//*")
#source_code = elem.get_attribute("outerHTML")

cheapest_price = mydriver.find_element_by_class_name("ResultPrice").text

print "Found cheapest price: ", cheapest_price

elems = mydriver.find_elements_by_class_name("ResultPrice")

print "All flight prices found from the first page:"
i = 0
for elem in elems:
	if elem.text != "":
		i += 1
		print "#",i," : ",elem.text

mydriver.quit

