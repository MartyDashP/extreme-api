Include ExtremeAPI.general

Class ExtremeAPI.Util.JavaType Extends %RegisteredObject
{

Parameter APISerializer = "io.github.martydashp.cache_extreme_api.Serializer";

Parameter APIDeserializer = "io.github.martydashp.cache_extreme_api.Deserializer";

Parameter APIConnection = "io.github.martydashp.cache_extreme_api.Connection";

Parameter APIAbstractDTO = "io.github.martydashp.cache_extreme_api.AbstractDTO";

Parameter CacheListReader = "com.intersys.jdbc.CacheListReader";

Parameter UtilList = "java.util.List";

ClassMethod GetSpecType(cacheType As %String, cacheCollectionType As %String) As JavaSpec.Model.Type
{
	s javaType = ##class(JavaSpec.Model.Type).%New()

	if (cacheType = "")
	{
		s javaType.Name = "void"
	}
	elseif $$$IsDataType(cacheType)
	{
		s javaType.Name = $case(cacheType,
			"%Library.String": "String",
			"%Library.Integer": "Integer",
			"%Library.Numeric": "Integer", 
			: "")
	}
	elseif $$$IsSupportedObjectType(cacheType)
	{
		s javaType.Name = cacheType
	}
	else
	{
		throw $$$UnsupportedTypeExeption(type)
	}
	
	if $$$IsCollectionAsList(cacheCollectionType)
	{
		s arg = ##class(JavaSpec.Model.Type).%New()
		s arg.Name = javaType.Name
			
		s javaType.Name = ..#UtilList
		s javaType.Arguments = ##class(%ListOfObjects).%New()
		$$$TOE(sc, javaType.Arguments.Insert(arg))
			
		ret javaType
	}
	
	ret javaType
}

ClassMethod MapValueType(type As %String) As %String
{
	s class = $case(type,
			##class(ExtremeAPI.Util.ObjectScriptType).#StringType: "String.class",
			##class(ExtremeAPI.Util.ObjectScriptType).#IntegerType: "Integer.class",
			##class(ExtremeAPI.Util.ObjectScriptType).#NumericType: "Integer.class", 
			: "")
			
	throw:(class = "") $$$UnsupportedTypeExeption(type)
	
	ret class
}

}
