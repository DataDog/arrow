% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dataset.R
\name{dataset_factory}
\alias{dataset_factory}
\title{Create a DatasetFactory}
\usage{
dataset_factory(
  x,
  filesystem = c("auto", "local"),
  format = c("parquet", "arrow", "ipc"),
  partitioning = NULL,
  allow_non_existent = FALSE,
  recursive = TRUE,
  ...
)
}
\arguments{
\item{x}{A string file x containing data files, or
a list of \code{DatasetFactory} objects whose datasets should be
grouped. If this argument is specified it will be used to construct a
\code{UnionDatasetFactory} and other arguments will be ignored.}

\item{filesystem}{A string identifier for the filesystem corresponding to
\code{x}. Currently only "local" is supported.}

\item{format}{A string identifier of the format of the files in \code{x}.
Currently supported options are "parquet", "arrow", and "ipc" (an alias for
the Arrow file format)}

\item{partitioning}{One of
\itemize{
\item A \code{Schema}, in which case the file paths relative to \code{sources} will be
parsed, and path segments will be matched with the schema fields. For
example, \code{schema(year = int16(), month = int8())} would create partitions
for file paths like "2019/01/file.parquet", "2019/02/file.parquet", etc.
\item A character vector that defines the field names corresponding to those
path segments (that is, you're providing the names that would correspond
to a \code{Schema} but the types will be autodetected)
\item A \code{HivePartitioning} or \code{HivePartitioningFactory}, as returned
by \code{\link[=hive_partition]{hive_partition()}} which parses explicit or autodetected fields from
Hive-style path segments
\item \code{NULL} for no partitioning
}}

\item{allow_non_existent}{logical: is \code{x} allowed to not exist? Default
\code{FALSE}. See \link{FileSelector}.}

\item{recursive}{logical: should files be discovered in subdirectories of
\code{x}? Default \code{TRUE}.}

\item{...}{Additional arguments passed to the \link{FileSystem} \verb{$create()} method}
}
\value{
A \code{DatasetFactory} object. Pass this to \code{\link[=open_dataset]{open_dataset()}},
in a list potentially with other \code{DatasetFactory} objects, to create
a \code{Dataset}.
}
\description{
A \link{Dataset} can constructed using one or more \link{DatasetFactory}s.
This function helps you construct a \code{DatasetFactory} that you can pass to
\code{\link[=open_dataset]{open_dataset()}}.
}
\details{
If you would only have a single \code{DatasetFactory} (for example, you have a
single directory containing Parquet files), you can call \code{open_dataset()}
directly. Use \code{dataset_factory()} when you
want to combine different directories, file systems, or file formats.
}
