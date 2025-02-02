package io.llambda.compiler.frontend
import io.llambda

import org.scalatest.FunSuite
import llambda.compiler._

class LibraryLoaderSuite extends FunSuite {
  implicit val defaultFrontendConfig =
    FrontendConfig(
      includePath=IncludePath(Nil),
      featureIdentifiers=Set(),
      schemeDialect=dialect.Dialect.default
    )

  test("load non-existant library") {
    val loader = new LibraryLoader(platform.Posix64LE)
    val nonExistantName = List("not", "a", "library")

    intercept[LibraryNotFoundException] {
      loader.load(nonExistantName)
    }

    assert(loader.exists(nonExistantName) === false)
  }

  test("dubious library names") {
    val loader = new LibraryLoader(platform.Posix64LE)

    intercept[DubiousLibraryNameComponentException] {
      loader.load(List("foo/bar"))
    }

    intercept[DubiousLibraryNameComponentException] {
      loader.exists(List("foo/bar"))
    }

    intercept[DubiousLibraryNameComponentException] {
      loader.load(List("bar\u0000baz"))
    }

    intercept[DubiousLibraryNameComponentException] {
      loader.exists(List("bar\u0000baz"))
    }
  }

  test("load scheme base") {
    val loader = new LibraryLoader(platform.Posix64LE)
    val bindings = loader.loadSchemeBase

    assert(bindings.contains("set!"))
  }

  test("load llambda primitives") {
    val loader = new LibraryLoader(platform.Posix64LE)
    val bindings = loader.load(List("llambda", "internal", "primitives"))

    assert(bindings.contains("set!"))
  }
  test("llambda primitives exists") {
    val loader = new LibraryLoader(platform.Posix64LE)

    assert(loader.exists(List("llambda", "internal", "primitives")) === true)
  }

  test("load llambda nfi") {
    val loader = new LibraryLoader(platform.Posix64LE)
    val bindings = loader.load(List("llambda", "nfi"))

    assert(bindings.contains("native-function"))
  }

  test("unmatched library name fails") {
    val loader = new LibraryLoader(platform.Posix64LE)

    intercept[LibraryNameMismatchException] {
      loader.load(List("test", "unmatchedname"))
    }
  }

  test("unmatched library name exists") {
    val loader = new LibraryLoader(platform.Posix64LE)

    // This is testing we don't attempt to parse in exists()
    assert(loader.exists(List("test", "unmatchedname")) === true)
  }


  test("load single expression library") {
    val loader = new LibraryLoader(platform.Posix64LE)

    loader.load(List("test", "singleexpr"))

    assert(loader.libraryExprs.length === 1)
  }

  test("single expression library exists") {
    val loader = new LibraryLoader(platform.Posix64LE)

    assert(loader.exists(List("test", "singleexpr")) === true)
  }

  test("load single expression library with non-default include path") {
    val loader = new LibraryLoader(platform.Posix64LE)

    val frontendConfig = FrontendConfig(
      includePath=IncludePath(
        userConfiguredPaths=List(getClass.getClassLoader.getResource("libraries/test/"))
      ),
      featureIdentifiers=Set(),
      schemeDialect=dialect.Dialect.default
    )

    // We should be able to load without the "text" prefix
    loader.load(List("pathedsingleexpr"))(frontendConfig)

    assert(loader.libraryExprs.length === 1)
  }

  test("single expression library with non-default include path exists") {
    val loader = new LibraryLoader(platform.Posix64LE)

    val frontendConfig = FrontendConfig(
      includePath=IncludePath(
        userConfiguredPaths=List(getClass.getClassLoader.getResource("libraries/test/"))
      ),
      featureIdentifiers=Set(),
      schemeDialect=dialect.Dialect.default
    )

    assert(loader.exists(List("pathedsingleexpr"))(frontendConfig) === true)
  }

  test("multiple loads don't introduce duplicate expressions") {
    val loader = new LibraryLoader(platform.Posix64LE)

    loader.load(List("test", "singleexpr"))
    loader.load(List("test", "singleexpr"))

    assert(loader.libraryExprs.length === 1)
  }

  test("multiple top-level data library") {
    val loader = new LibraryLoader(platform.Posix64LE)

    intercept[BadSpecialFormException] {
      loader.load(List("test", "multipledatum"))
    }
  }
}
