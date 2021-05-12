import java.time.Instant
import kotlinx.coroutines.*

fun timeInMillis(label: String, func: () -> Any) {
  val startInstant = Instant.now()
  func()
  val time = Instant.now().toEpochMilli() - startInstant.toEpochMilli()
  println("${label} executed in ${time}ms")
}

fun main() {
  timeInMillis("sequential") {
    for (i in 1..10) {
       Thread.sleep(150)         
    }
  }
  timeInMillis("coroutine") {
    runBlocking {
      for (i in 1..10) {
        launch { 
          withContext(Dispatchers.IO) { delay(150) }
        }          
      }
    }
  }
}