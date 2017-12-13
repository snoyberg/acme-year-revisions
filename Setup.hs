import Distribution.Simple
import System.Directory
import Distribution.PackageDescription
import Distribution.PackageDescription.Parse

main :: IO ()
main = defaultMainWithHooks simpleUserHooks
  { preBuild = \args buildFlags -> do
      gpd <- readPackageDescription minBound "acme-year-revisions.cabal"
      let desc = description $ packageDescription gpd
      createDirectoryIfMissing True "src/Acme/Year"
      writeFile "src/Acme/Year/Revisions.hs" $ unlines
        [ "module Acme.Year.Revisions (year) where"
        , ""
        , "-- | The current year"
        , "year :: Int"
        , "year = " ++ desc
        ]
      preBuild simpleUserHooks args buildFlags
  }
