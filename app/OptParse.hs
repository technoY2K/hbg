module OptParse where

import           Data.Maybe          (fromMaybe)
import           Options.Applicative

data Options
    = ConvertSingle SingleInput SingleOutput
    | ConvertDir FilePath FilePath
    deriving Show

data SingleInput
    = Stdin
    | InputFile FilePath
    deriving Show

data SingleOutput
    = Stdout
    | OutputFile FilePath
    deriving Show

pInputFile :: Parser SingleInput
pInputFile = fmap InputFile parser
    where
        parser =
            strOption
                (
                    long "input"
                    <> short 'i'
                    <> metavar "FILE"
                    <> help "Input file"
                )

pOutputFile :: Parser SingleOutput
pOutputFile = fmap OutputFile parser
    where
        parser =
            strOption
                (
                    long "output"
                    <> short 'o'
                    <> metavar "File"
                    <> help "Output file"
                )

pConvertSingle :: Parser Options
pConvertSingle = ConvertSingle <$> pInputFile <*> pOutputFile

pInputDir :: Parser FilePath
pInputDir =
    strOption
        (
            long "input"
            <> short 'i'
            <> metavar "DIRECTORY"
            <> help "Input directory"
        )

pOutputDir :: Parser FilePath
pOutputDir =
    strOption
        (
            long "output"
            <> short 'o'
            <> metavar "DIRECTORY"
            <> help "Output directory"
        )

pConvertDir :: Parser Options
pConvertDir = ConvertDir <$> pInputDir <*> pOutputDir
