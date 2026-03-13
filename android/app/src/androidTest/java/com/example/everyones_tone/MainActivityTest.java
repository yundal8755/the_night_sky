package com.example.everyones_tone;

import androidx.test.platform.app.InstrumentationRegistry;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.Parameterized;

import pl.leancode.patrol.PatrolJUnitRunner;

@RunWith(Parameterized.class)
public class MainActivityTest {
  @Parameterized.Parameters(name = "{0}")
  public static Object[] testCases() {
    PatrolJUnitRunner instrumentation =
        (PatrolJUnitRunner) InstrumentationRegistry.getInstrumentation();
    instrumentation.setUp(MainActivity.class);
    instrumentation.waitForPatrolAppService();
    return instrumentation.listDartTests();
  }

  @Parameterized.Parameter
  public String dartTestName;

  @Test
  public void runDartTest() {
    PatrolJUnitRunner instrumentation =
        (PatrolJUnitRunner) InstrumentationRegistry.getInstrumentation();
    instrumentation.runDartTest(dartTestName);
  }
}
