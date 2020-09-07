/*
 * generated by Xtext 2.22.0
 */
package edf.validation

import edf.forml0.AdditionExpression
import edf.forml0.BecomesExpression
import edf.forml0.BooleanFromCtl
import edf.forml0.BooleanLiteral
import edf.forml0.ChangesExpression
import edf.forml0.Clock
import edf.forml0.Ctl
import edf.forml0.DivisionExpression
import edf.forml0.DropExpression
import edf.forml0.Event
import edf.forml0.EventLiteral
import edf.forml0.EveryExpression
import edf.forml0.Expression
import edf.forml0.FirstExpression
import edf.forml0.FollowingExpression
import edf.forml0.FunctionCall
import edf.forml0.IfExpression
import edf.forml0.IntegerDivisionExpression
import edf.forml0.LeavesExpression
import edf.forml0.MyClock
import edf.forml0.MyRate
import edf.forml0.MyValue
import edf.forml0.NumericLiteral
import edf.forml0.PowerExpression
import edf.forml0.ProductExpression
import edf.forml0.PropertyEvent
import edf.forml0.PropertyPfd
import edf.forml0.PropertyState
import edf.forml0.Reference
import edf.forml0.SubstractionExpression
import edf.forml0.Time
import edf.forml0.UnaryMinusExpression
import edf.forml0.WhileExpression
import edf.forml0.WithoutExpression
import edf.forml0.inPTime
import edf.forml0.EqualityExpression
import com.google.inject.Inject
import edf.forml0.DifferenceExpression
import edf.forml0.LessThanExpression
import edf.forml0.LessOrEqualExpression
import edf.forml0.GreaterThanExpression
import edf.forml0.GreaterOrEqualExpression
import edf.forml0.NotExpression
import edf.forml0.AndExpression
import edf.forml0.OrExpression
import edf.forml0.XorExpression
import edf.forml0.BuiltInFunctionCall
import edf.forml0.AttributeExpression
import edf.forml0.Second
import edf.forml0.Tick
import edf.forml0.ClockTime
import edf.forml0.InPClockTime

//=============================================================================
//
//	Boolean Constraint category
//
//=============================================================================
interface Forml0ConstraintCategory {override String toString()}
class esConstraint     implements Forml0ConstraintCategory {override String toString() {"early satisfaction Constraint"}}
class lsConstraint     implements Forml0ConstraintCategory {override String toString() {"late satisfaction Constraint" }}
class notELSConstraint implements Forml0ConstraintCategory {override String toString() {"not an achievement Constraint"}}

class Forml0ConstraintCategoryProvider {
	// Variability of expressions
	// constant is a subtype of fixed: it is allowed whenever constant is
	public static val esConstraint   = new esConstraint
	public static val lsConstraint   = new lsConstraint
	public static val notELSConstraint = new notELSConstraint
	
	@Inject extension Forml0VariabilityProvider
	
	def dispatch Forml0ConstraintCategory constraintCategoryFor (Expression expr) {
		switch (expr) {
			NumericLiteral:				notELSConstraint
			Second:						notELSConstraint
			Time:						notELSConstraint
			inPTime:					notELSConstraint
			Tick:						notELSConstraint
			ClockTime:					notELSConstraint
			InPClockTime:				notELSConstraint
			MyRate:						notELSConstraint
			PropertyPfd:				notELSConstraint
			BuiltInFunctionCall:		notELSConstraint
			
			BooleanLiteral:				notELSConstraint
			PropertyState:				notELSConstraint
			BooleanFromCtl:				notELSConstraint
			
			MyValue:					notELSConstraint
			
			EventLiteral:				notELSConstraint
			PropertyEvent:				notELSConstraint
			MyClock:					notELSConstraint
			Clock:						notELSConstraint
			Reference:					notELSConstraint
			FunctionCall:				notELSConstraint
		
			AttributeExpression:		notELSConstraint
			PowerExpression:			notELSConstraint
			UnaryMinusExpression:		notELSConstraint
		///	NotExpression:				
			FirstExpression:			notELSConstraint
			DropExpression:				notELSConstraint
			ProductExpression:			notELSConstraint
			DivisionExpression:			notELSConstraint
			IntegerDivisionExpression:	notELSConstraint
			AdditionExpression:			notELSConstraint
			SubstractionExpression:		notELSConstraint
			WithoutExpression:			notELSConstraint
			FollowingExpression:		notELSConstraint
		///	EqualityExpression:			1.0
		///	DifferenceExpression:		1.0
		///	LessThanExpression:			1.0
		///	LessOrEqualExpression:		1.0
		///	GreaterThanExpression:		1.0
		///	GreaterOrEqualExpression:	1.0
		///	AndExpression:				1.0
			WhileExpression:			notELSConstraint
		///	OrExpression:				1.0			
		///	XorExpression:				1.0			
			IfExpression:				notELSConstraint
			EveryExpression:			notELSConstraint
			ChangesExpression:			notELSConstraint
			BecomesExpression:			notELSConstraint
			LeavesExpression:			notELSConstraint
		}
	}
	
	def dispatch Forml0ConstraintCategory constraintCategoryFor (EqualityExpression expr) {
		((isIncreasing (expr.left.variabilityFor) && isDecreasing (expr.right.variabilityFor)) ||
		 (isDecreasing (expr.left.variabilityFor) && isIncreasing (expr.right.variabilityFor))) ? lsConstraint : notELSConstraint
	}	
	
	def dispatch Forml0ConstraintCategory constraintCategoryFor (DifferenceExpression expr) {
		((isIncreasing (expr.left.variabilityFor) && isDecreasing (expr.right.variabilityFor)) ||
		 (isDecreasing (expr.left.variabilityFor) && isIncreasing (expr.right.variabilityFor))) ? esConstraint : notELSConstraint
	}	
	
	def dispatch Forml0ConstraintCategory constraintCategoryFor (LessThanExpression expr) {
		if      (isIncreasing (expr.left.variabilityFor) && isDecreasing (expr.right.variabilityFor)) lsConstraint
		else if	(isDecreasing (expr.left.variabilityFor) && isIncreasing (expr.right.variabilityFor)) esConstraint 
		else notELSConstraint
	}	
	
	def dispatch Forml0ConstraintCategory constraintCategoryFor (LessOrEqualExpression expr) {
		if      (isIncreasing (expr.left.variabilityFor) && isDecreasing (expr.right.variabilityFor)) lsConstraint
		else if	(isDecreasing (expr.left.variabilityFor) && isIncreasing (expr.right.variabilityFor)) esConstraint 
		else notELSConstraint
	}	
	
	def dispatch Forml0ConstraintCategory constraintCategoryFor (GreaterThanExpression expr) {
		if      (isIncreasing (expr.left.variabilityFor) && isDecreasing (expr.right.variabilityFor)) esConstraint
		else if	(isDecreasing (expr.left.variabilityFor) && isIncreasing (expr.right.variabilityFor)) lsConstraint 
		else notELSConstraint
	}	
	
	def dispatch Forml0ConstraintCategory constraintCategoryFor (GreaterOrEqualExpression expr) {
		if      (isIncreasing (expr.left.variabilityFor) && isDecreasing (expr.right.variabilityFor)) esConstraint
		else if	(isDecreasing (expr.left.variabilityFor) && isIncreasing (expr.right.variabilityFor)) lsConstraint 
		else notELSConstraint
	}	
	
	def dispatch Forml0ConstraintCategory constraintCategoryFor (NotExpression expr) {
		if      (expr.right.constraintCategoryFor == esConstraint) lsConstraint
		else if	(expr.right.constraintCategoryFor == lsConstraint) esConstraint 
		else notELSConstraint
	}	
	
	def dispatch Forml0ConstraintCategory constraintCategoryFor (AndExpression expr) {
		if      (expr.left.constraintCategoryFor == esConstraint || expr.right.constraintCategoryFor == esConstraint) esConstraint
		else if	(expr.left.constraintCategoryFor == lsConstraint || expr.right.constraintCategoryFor == lsConstraint) lsConstraint 
		else if	(expr.left.constraintCategoryFor == esConstraint || expr.right.constraintCategoryFor == lsConstraint) lsConstraint 
		else if	(expr.left.constraintCategoryFor == lsConstraint || expr.right.constraintCategoryFor == esConstraint) lsConstraint 
		else notELSConstraint
	}	
	
	def dispatch Forml0ConstraintCategory constraintCategoryFor (OrExpression expr) {
		if      (expr.left.constraintCategoryFor == esConstraint || expr.right.constraintCategoryFor == esConstraint) esConstraint
		else if	(expr.left.constraintCategoryFor == lsConstraint || expr.right.constraintCategoryFor == lsConstraint) lsConstraint 
		else if	(expr.left.constraintCategoryFor == esConstraint || expr.right.constraintCategoryFor == lsConstraint) esConstraint 
		else if	(expr.left.constraintCategoryFor == lsConstraint || expr.right.constraintCategoryFor == esConstraint) esConstraint 
		else notELSConstraint
	}	
	
	def dispatch Forml0ConstraintCategory constraintCategoryFor (XorExpression expr) {
		if      (expr.left.constraintCategoryFor == esConstraint || expr.right.constraintCategoryFor == esConstraint) lsConstraint
		else if	(expr.left.constraintCategoryFor == lsConstraint || expr.right.constraintCategoryFor == lsConstraint) lsConstraint 
		else if	(expr.left.constraintCategoryFor == esConstraint || expr.right.constraintCategoryFor == lsConstraint) esConstraint 
		else if	(expr.left.constraintCategoryFor == lsConstraint || expr.right.constraintCategoryFor == esConstraint) esConstraint 
		else notELSConstraint
	}	
	
	def private boolean isIncreasing (Forml0Variability variability) {
		variability == Forml0VariabilityProvider::constant ||
		variability == Forml0VariabilityProvider::fixed    ||
		variability == Forml0VariabilityProvider::increasing
	}
	
	def private boolean isDecreasing (Forml0Variability variability) {
		variability == Forml0VariabilityProvider::constant ||
		variability == Forml0VariabilityProvider::fixed    ||
		variability == Forml0VariabilityProvider::decreasing
	}
	
}	