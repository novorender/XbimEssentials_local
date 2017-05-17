using System;
using log4net;
using System.Text;
using System.Linq;
using System.Collections.Generic;
using Xbim.Common.Enumerations;
using Xbim.Common.ExpressValidation;
using Xbim.Ifc4.Interfaces;
// ReSharper disable once CheckNamespace
// ReSharper disable InconsistentNaming
namespace Xbim.Ifc4.StructuralElementsDomain
{
	public partial class IfcReinforcingMeshType : IExpressValidatable
	{
		public enum IfcReinforcingMeshTypeClause
		{
			CorrectPredefinedType,
			BendingShapeCodeProvided,
		}

		/// <summary>
		/// Tests the express where-clause specified in param 'clause'
		/// </summary>
		/// <param name="clause">The express clause to test</param>
		/// <returns>true if the clause is satisfied.</returns>
		public bool ValidateClause(IfcReinforcingMeshTypeClause clause) {
			var retVal = false;
			try
			{
				switch (clause)
				{
					case IfcReinforcingMeshTypeClause.CorrectPredefinedType:
						retVal = (PredefinedType != IfcReinforcingMeshTypeEnum.USERDEFINED) || ((PredefinedType == IfcReinforcingMeshTypeEnum.USERDEFINED) && Functions.EXISTS(this/* as IfcElementType*/.ElementType));
						break;
					case IfcReinforcingMeshTypeClause.BendingShapeCodeProvided:
						retVal = !Functions.EXISTS(BendingParameters) || Functions.EXISTS(BendingShapeCode);
						break;
				}
			} catch (Exception ex) {
				var Log = LogManager.GetLogger("Xbim.Ifc4.StructuralElementsDomain.IfcReinforcingMeshType");
				Log.Error(string.Format("Exception thrown evaluating where-clause 'IfcReinforcingMeshType.{0}' for #{1}.", clause,EntityLabel), ex);
			}
			return retVal;
		}

		public override IEnumerable<ValidationResult> Validate()
		{
			foreach (var value in base.Validate())
			{
				yield return value;
			}
			if (!ValidateClause(IfcReinforcingMeshTypeClause.CorrectPredefinedType))
				yield return new ValidationResult() { Item = this, IssueSource = "IfcReinforcingMeshType.CorrectPredefinedType", IssueType = ValidationFlags.EntityWhereClauses };
			if (!ValidateClause(IfcReinforcingMeshTypeClause.BendingShapeCodeProvided))
				yield return new ValidationResult() { Item = this, IssueSource = "IfcReinforcingMeshType.BendingShapeCodeProvided", IssueType = ValidationFlags.EntityWhereClauses };
		}
	}
}