/*
 * generated by Xtext 2.22.0
 */
package edf.tests

import com.google.inject.Inject
import edf.forml0.Model
import org.eclipse.xtext.testing.InjectWith
import org.eclipse.xtext.testing.extensions.InjectionExtension
import org.eclipse.xtext.testing.util.ParseHelper
import org.junit.jupiter.api.Assertions
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.^extension.ExtendWith
import org.eclipse.xtext.testing.validation.ValidationTestHelper

@ExtendWith(InjectionExtension)
@InjectWith(Forml0InjectorProvider)

class Forml0ParsingTest {
	@Inject
	ParseHelper<Model> parseHelper
	
	@Test
	def void expression1() {
		val result = parseHelper.parse('''
			Integer i1 is 5;
			Integer i2 is external;
			Event e is external;
			Real r1 is e.rate;
			Integer i3 is i2.previous;
			Real r2 is r1^5;
			Real r3 is i1^-4;
			Real r4 is -r3;
			Real r5 is -r1^5;
			Boolean b1 is true;
			Boolean b2 is not b1;
			Boolean b3 is b1;
			Event e2 is first e;
			Event e3 is drop first e;
			Event e4 is first (5) e;
			Event e5 is drop first (2) e;
			Real r6 is r1*r2*r4;
			Real r7 is r1*i1;
			Real r8 is i1;
			Real r9 is 5*(r1+r2);
			Real r10 is r1/r2;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: �errors.join(", ")�''')
	}
 	
	@Test
	def void boolean1() {
		val result = parseHelper.parse('''
			Integer i1 is external;
			Integer i2 is external;
			Event e1 is external;
			Ctl ctl1 is for 5*s;
			Boolean b1 is false;
			Boolean b2 begin
				define value is b1;
			end;
			Boolean b3 begin
				clock is t0;
			end;
			Boolean b4 begin
				clock is t0;
				define value is b2;
			end;
			Boolean b5 begin
				when t0 define value is true;
				during b1 define next is i1 > i2;
				during b2 define value is previous;
			end;
			Boolean b6 begin
				clock is at every 5*s;
				at every 5*s define value is true;
				during ctl1 define next is false;
				during b2 define value is previous;
			end;
			Boolean b7 is external;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: �errors.join(", ")�''')
	}
 	
	@Test
	def void float1() {
		val result = parseHelper.parse('''
			Boolean b1 is false;
			Boolean b2 begin
				when     t0     define value is b1;
				for      1      define next  is true;
				for      1.1    define next  is true;
				for      1.5    define next  is true;
				for      1e+2   define next  is true;
				for      1e-2   define next  is true;
				for      1.5e-2 define next  is true;
				for      1.e-2  define next  is true;
				for      1E-2   define next  is true;
				for      1.5E-2 define next  is true;
				at every 1.E-2  define next  is true;
			end;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: �errors.join(", ")�''')
	}
	
	@Test
	def void integer1() {
		val result = parseHelper.parse('''
			Integer integer1 is external;
			Integer integer2 begin
				during true define value is 5;
				when integer1 becomes 5 define next is integer1;
			end;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: �errors.join(", ")�''')
	}
	
	@Test
	def void real1() {
		val result = parseHelper.parse('''
			Boolean b is external;
			Integer i is external;
			Real _r begin
				clock is at every 10;
				from t0 until t0                             define value is 1;
				after t0 until t0                            define next  is 1.;
				from t0 before t0                            define value is 1.1;
				after t0 before t0                           define value is 1e+2;
				when b becomes true                          define next  is 11.E-2;
				before i becomes 5                           define next  is .3e+5;
				after i leaves 5                             define value is .5;
				from i leaves [5, ] becomes ] , [            define value is 0.1e+2;
				before i leaves {[ , 7], 10} becomes 30      define value is 2;
				until b changes                              define value is i;
				from b becomes true for 2.5					 define value is 2;
				after b leaves false for 2.5				 define value is 2;
				after i leaves 30 becomes {7} within 2.      define value is 2;
				from i leaves {30} becomes 7 within 2.       define value is 2;
			end;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: �errors.join(", ")�''')
	}
  	
	@Test
	def void event1() {
		val result = parseHelper.parse('''
			Event e1 is t0;
			Event e2 is external;
			Boolean b is external;
			Real r is external;
			Event event1 begin
				clock is at every 10;
				define occurrence is t0;
			end;
			Event event2 begin
				clock is t0;
				define rate is 10;
			end;
			Event event3 begin
				clock is b becomes true;
				during b            define occurrence is t0;
				when b becomes true define occurrence is e1;
				during b            define rate       is 1.1;
			end;
			Event event4 begin
				define occurrence is t0;
			end;
			Event event5 begin
				define rate is 5;
			end;
			Event event6 begin
				during b define occurrence is e1;
				during b define rate is 1.1;
			end;
/**/		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: �errors.join(", ")�''')
	}
	
	@Test
	def void ctl1() {
		val result = parseHelper.parse('''
			Integer i is external;
			Boolean b is external;
			Real r is external;
			Real r1 is external;
			Event e is external;
			Event e1 is external;
			Ctl ctl1  is from   e;
			Ctl ctl2  is after  e;
			Ctl ctl3  is before e;
			Ctl ctl4  is until  e;
			Ctl ctl5  is from   e for    10;
			Ctl ctl6  is after  e for    5;
			Ctl ctl7  is from   e within 5;
			Ctl ctl8  is after  e within 5;
			Ctl ctl9  is from   e before e1;
			Ctl ctl10 is after  e before e1;
			Ctl ctl11 is from   e until  e1;
			Ctl ctl12 is after  e until  e1;
			Ctl ctl13 is from  every 10 for    5;
			Ctl ctl14 is after every 10 for    5;
			Ctl ctl15 is from  every 10 within 5;
			Ctl ctl16 is after every 10 within 5;
			Ctl ctl17 is for    5;
			Ctl ctl18 is within 5;
			Ctl xtl19 is during ctl11;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: �errors.join(", ")�''')
	}
		
	@Test
	def void dtl1() {
		val result = parseHelper.parse('''
			Real r is external;
			Event e is external;
			Event dtl1  is e;
			Event dtl2  is at every 10;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: �errors.join(", ")�''')
	}
		
	@Test
	def void property1() {
		val result = parseHelper.parse('''
			Real r is external;
			Event e1 is external;
			Event dtl1  is e;
			Event dtl2  is at every 5;
			Boolean b is external;
			Boolean b2 is external;
			Property    p1  is             				ensure			   b;
			Assumption  p2  is 						can ensure			   b;
			Requirement p3  is             				achieve 		   b;
			Guard       p4  is 						can achieve 		   b;
			Objective   p5  is     						achieve at closing b;
			Property    p6  is 						can achieve at closing b;
			Property    p7  is at every 10              ensure  		   b;
			Assumption  p8  is t0                   can ensure			   b;
			Requirement p9  is during b2                achieve			   b;
			Guard       p10 is from dtl1 until dtl2 can achieve			   b;
			Objective   p11 is e                        achieve at closing b;
			Property    p12 is during b2            can achieve at closing b;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: �errors.join(", ")�''')
	}
 		
	@Test
	def void function1() {
		val result = parseHelper.parse('''
			Boolean b0                        is external;
			Integer i0						  is external;
			Real    r0                        is external;
			Event   e						  is external;
			Ctl     c						  is during b0;
			Real    d                         is duration (b0);
			Real    d2                        is inPDuration (b0);
			Integer i1                        is count(e);
			Integer i2                        is inPCount(e);
			Real    r1                        is inTMax(i1);
			Real    r2                        is inTMin(r1);
			Boolean b                         is boolean(during b0);
			Boolean b1                        is boolean(during c);
/* */	
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: �errors.join(", ")�''')
	}
 		
	@Test
	def void atom1() {
		val result = parseHelper.parse('''
			Boolean b is external;
			Property p is ensure  b;
			Boolean s1 is p.satisfaction;
			Boolean v is p.violation;
			Event e is p.eViolation;
			Event e2 is p.eSatisfaction;
			Event e3 is b.clock;
			Real r is e2.rate;
			Real x is (e2.rate);
			Real y is r;
			Real h is b.clock;
			Integer l is count (e);
			Boolean b2 is true;
			Boolean b3 is false;
			Boolean b4 is b2.previous;
			Boolean b5 is b2;
			Boolean b6 is b5.previous;
			Boolean b7 is b5;			
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: �errors.join(", ")�''')
	}
 		
	@Test
	def void first() {
		val result = parseHelper.parse('''
			Event e is external;
			Boolean b is external;
			Event e2 is first e;
			Event e3 is first (5) e;
			Event e4 is drop first e;
			Event e5 is drop first (4) e;
			Event e6 is first (first e);
			Event e7 is drop first (first e);
			Event e8 is drop first (2) (first (4) e);
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: �errors.join(", ")�''')
	}
 		
	@Test
	def void dtlOperators() {
		val result = parseHelper.parse('''
			Event e1 is external;
			Event e2 is external;
			Boolean b is external;
			Ctl ctl1 is from e1 for 5;
			Real d is 20.2;
			Event e3 is e1 or e2;
			Event e4 is e1 + 5.5;
			Event e5 is (e1 or e2) + 5.5;
			Event e6 is e1 without e2;
			Event e7 is e1 while b;
			Event e8 is e1 while ctl1;
		''')
		Assertions.assertNotNull(result)
		val errors = result.eResource.errors
		Assertions.assertTrue(errors.isEmpty, '''Unexpected errors: �errors.join(", ")�''')
	}
 		
 		
}

