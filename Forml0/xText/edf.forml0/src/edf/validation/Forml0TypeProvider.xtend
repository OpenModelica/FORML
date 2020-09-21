/*
 * generated by Xtext 2.22.0
 */
package edf.validation

import edf.forml0.AdditionExpression
import edf.forml0.AndExpression
import edf.forml0.BecomesExpression
import edf.forml0.Boolean
import edf.forml0.BooleanFromCtl
import edf.forml0.BooleanLiteral
import edf.forml0.ChangesExpression
import edf.forml0.Clock
import edf.forml0.Ctl
import edf.forml0.DifferenceExpression
import edf.forml0.DivisionExpression
import edf.forml0.DropExpression
import edf.forml0.EqualityExpression
import edf.forml0.Event
import edf.forml0.EventLiteral
import edf.forml0.EveryExpression
import edf.forml0.Expression
import edf.forml0.FirstExpression
import edf.forml0.FollowingExpression
import edf.forml0.FunctionCall
import edf.forml0.GreaterOrEqualExpression
import edf.forml0.GreaterThanExpression
import edf.forml0.IfExpression
import edf.forml0.Integer
import edf.forml0.IntegerDivisionExpression
import edf.forml0.Item
import edf.forml0.LeavesExpression
import edf.forml0.LessOrEqualExpression
import edf.forml0.LessThanExpression
import edf.forml0.MyClock
import edf.forml0.MyRate
import edf.forml0.MyValue
import edf.forml0.NotExpression
import edf.forml0.NumericLiteral
import edf.forml0.OrExpression
import edf.forml0.PowerExpression
import edf.forml0.ProductExpression
import edf.forml0.Property
import edf.forml0.PropertyEvent
import edf.forml0.PropertyPfd
import edf.forml0.PropertyState
import edf.forml0.Real
import edf.forml0.Reference
import edf.forml0.SubstractionExpression
import edf.forml0.Time
import edf.forml0.UnaryMinusExpression
import edf.forml0.WhileExpression
import edf.forml0.WithoutExpression
import edf.forml0.XorExpression
import edf.forml0.inPTime

import static extension org.eclipse.xtext.EcoreUtil2.*
import edf.forml0.BuiltInFunctionCall
import edf.forml0.AttributeExpression
import edf.forml0.Second
import edf.forml0.Tick
import edf.forml0.ClockTime
import edf.forml0.InPClockTime
import edf.forml0.MyDerivative
import edf.forml0.InIntervalExpression

//=============================================================================
//
//	Type computation for expressions
//
//=============================================================================
interface Forml0Type {override String toString()}
class BooleanType  implements Forml0Type {override String toString() {"Boolean"}}
class IntegerType  implements Forml0Type {override String toString() {"Integer"}}
class NumericType  implements Forml0Type {override String toString() {"Integer or Real"}}
class EventType    implements Forml0Type {override String toString() {"Event"}}
class CtlType      implements Forml0Type {override String toString() {"Ctl"}}
class PropertyType implements Forml0Type {override String toString() {"Property"}}
class UnknownType  implements Forml0Type {override String toString() {"unknown"}}

class Forml0TypeProvider {
	// Types of expressions
	// integerType is a subtype of numericType: it is allowed whenever numericType is
	public static val booleanType = new BooleanType
	public static val numericType = new NumericType
	public static val integerType = new IntegerType
	public static val eventType   = new EventType
	public static val propertyType= new PropertyType
	public static val ctlType     = new CtlType
	public static val unknownType = new UnknownType
	
	def dispatch Forml0Type typeFor (Expression expr) {
		switch (expr) {
		///	NumericLiteral
			Second:						integerType
			Time:						numericType
			inPTime:					numericType
			Tick:						integerType
			ClockTime:					integerType
			InPClockTime:				integerType
			MyDerivative:				numericType
			MyRate:						numericType
			PropertyPfd:				numericType
		///	BuiltInFunctionCall:		
			
			BooleanLiteral:				booleanType
			PropertyState:				booleanType
			BooleanFromCtl:				booleanType
			
		///	MyValue
		
			EventLiteral:				eventType
			PropertyEvent:				eventType
			MyClock:					eventType
			Clock:						eventType
			
		///	Reference
		///	FunctionCall
		
		///	AttributeExpression:		
			PowerExpression:			expr.left  ?. typeFor ?: unknownType
			UnaryMinusExpression:		expr.right ?. typeFor ?: unknownType
			NotExpression:				booleanType
			FirstExpression:			eventType
			DropExpression:				eventType
			ProductExpression:			if (expr.left?.typeFor == integerType && expr.right?.typeFor == integerType) 
											integerType else numericType
			DivisionExpression:			numericType
			IntegerDivisionExpression:	integerType
		///	AdditionExpression
			SubstractionExpression:		if (expr.left?.typeFor == integerType && expr.right?.typeFor == integerType) 
											integerType else numericType
			WithoutExpression:			eventType
			FollowingExpression:		eventType
			EqualityExpression:			booleanType
			DifferenceExpression:		booleanType
			LessThanExpression:			booleanType
			LessOrEqualExpression:		booleanType
			GreaterThanExpression:		booleanType
			GreaterOrEqualExpression:	booleanType
			InIntervalExpression:		booleanType
			AndExpression:				booleanType
			WhileExpression:			eventType
			OrExpression:				expr.left ?. typeFor ?: unknownType
			XorExpression:				expr.left ?. typeFor ?: unknownType
		///	IfExpression
			EveryExpression:			eventType
			ChangesExpression:			eventType
			BecomesExpression:			eventType
			LeavesExpression:			eventType
		}
	}
	
	def dispatch Forml0Type typeFor (NumericLiteral expr) {
		 if (expr.value.decimalPoint 
		 ||  expr.value.decimalValue !== null 
		 ||  expr.value.exponent     !== null
		 ) numericType else integerType
	}
	
	def dispatch Forml0Type typeFor (MyValue expr) {
		 switch expr.getContainerOfType(typeof(Item)) {
		 	Boolean: booleanType
		 	Integer: integerType
		 	Real:    numericType
		 }
	}

	def dispatch Forml0Type typeFor (Reference expr) {
		 switch expr?.identifier {
		 	Boolean: booleanType
		 	Integer: integerType
		 	Real:	 numericType
		 	Event:	 eventType
		 	Property:propertyType
		 	Ctl:	 ctlType
		 	default: unknownType
		 }
	}
	
	def dispatch Forml0Type typeFor (BuiltInFunctionCall expr) {
		 switch expr?.function {
		 	case 'count': 			integerType
		 	case 'duration':    	numericType
		 	case 'clockDuration':	integerType
		 	case 'inPCount': 		integerType
		 	case 'inPuration':  	numericType
		 	case 'inPlockDuration':	integerType
		 	case 'inPMax':			expr.argument ?. typeFor ?: unknownType
		 	case 'inPMin':			expr.argument ?. typeFor ?: unknownType
		 	case 'inTMax':			expr.argument ?. typeFor ?: unknownType
		 	case 'inTMin':			expr.argument ?. typeFor ?: unknownType
		 	case 'probability': 	numericType
		 }
	}
	
	def dispatch Forml0Type typeFor (FunctionCall expr) {
		 switch  expr?.function {
		 	Boolean: booleanType
		 	Integer: integerType
		 	Real: 	 numericType
		 	Event:	 eventType
		 }
	}
	
	def dispatch Forml0Type typeFor (AttributeExpression expr) {
		 if (expr.rate || expr.derivative || expr.integral) return numericType
		 expr.atom ?. typeFor ?: unknownType
	}
	
	def dispatch Forml0Type typeFor (AdditionExpression expr) {
		 switch expr.left ?. typeFor ?: unknownType {
		 	case eventType: 	eventType
		 	case integerType:	expr.right ?. typeFor ?: numericType
		 	case numericType:	if (expr.right ?. typeFor ?: unknownType == eventType) eventType else numericType
		 	default: 			unknownType
		 }
	}
	
	def dispatch Forml0Type typeFor (IfExpression expr) {
		 switch expr.then ?. typeFor ?: unknownType {
		 	case eventType: 	eventType
		 	case booleanType:	booleanType
		 	case integerType:	expr.^else ?. typeFor ?: numericType
		 	case numericType:	numericType
		 	default: 			unknownType
		 }
	}
	
}

