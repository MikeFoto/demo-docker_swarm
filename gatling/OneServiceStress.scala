import scala.concurrent.duration._

import io.gatling.core.Predef._
import io.gatling.http.Predef._
import io.gatling.jdbc.Predef._

class OneServiceStress extends Simulation {

	object GetPages {

   val nbPages = Integer.getInteger("pages", 1).toInt
   val nbPause = Integer.getInteger("pause", 1).toInt

		val getpage = repeat(nbPages,"n") {
			exec(http("Micro_service_home_page ${n}")
			.get("/"))
			.pause(nbPause)
		  }
  }

	val url = System.getProperty("url")
	val MicroService = http
		.baseURL(url)
		.inferHtmlResources()
		.acceptHeader("text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8")
		.acceptEncodingHeader("gzip, deflate")
		.acceptLanguageHeader("en-US,en;q=0.5")
		.userAgentHeader("Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:28.0) Gecko/20100101 Firefox/28.0")
		.check(status.is(200))

	val MyScenario = scenario("Microservice get1 Pages")
	                   .exec(GetPages.getpage)

  val nbUsers = Integer.getInteger("users", 1).toInt
		setUp(
			MyScenario
			  .inject(atOnceUsers(nbUsers))
			    .protocols(MicroService)
		)

}
