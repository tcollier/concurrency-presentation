import java.math.BigInteger
import java.time.Instant
import java.util.Random
import kotlinx.coroutines.*

fun timeInMillis(label: String, func: () -> Any) {
  val startInstant = Instant.now()
  func()
  val time = Instant.now().toEpochMilli() - startInstant.toEpochMilli()
  println("${label} executed in ${time}ms")
}

fun bigProbablePrime(): BigInteger {
  return BigInteger(1500, Random()).nextProbablePrime()
}

fun main() {
  timeInMillis("sequential") {
    for (i in 1..10) {
      bigProbablePrime()
    }
  }
  timeInMillis("coroutine") {
    runBlocking {
      for (i in 1..10) {
        launch {
		  withContext(Dispatchers.Default) {
		    bigProbablePrime()
		  }
		}
      }
    }
  }
}