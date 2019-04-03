# Dynasty Scans Downloader

**Note**: Dynasty Scans is a website that hosts manga and user-submitted content, some of which may be offensive. Only visit if you are at least 18 years of age.

Dynasty Scans Downloader is a Bash script for downloading manga from the website [Dynasty Scans](https://dynasty-scans.com/).

## Usage

### Dependencies

This is a bash script and thus should be run on a macOS or Linux machine. There are dependencies that need to be installed.

* `pcregrep`
  * macOS: `brew install pcre`
  * This could also be altered to support GNU grep by replacing every instance of `pcregrep` with `grep -P`.
* `7zip`
  * macOS: `brew install p7zip`

### Running

Run the script in the directory you want the chapters to be downloaded to with the name of the manga as seen in the URL of the page as the first command line argument. The images from each chapter will be placed in that chapter's own sub folder.

Dynasty Scans only allows 8 downloads per day per IP address, so once the download limit is reached, the script will stop and inform you what chapter it stopped on. When you're ready to continue downloading (either through it being the next day or you having a new IP), run the command again with the given chapter as an extra command line argument.

### Example

To download the chapters of [Yuru Camp](https://dynasty-scans.com/series/yurucamp), create and navigate to a folder you want the chapters to be downloaded to. Assuming you place the script in the folder above this one, run the command:

    ../DynastyScans.sh yurucamp

Assuming you reach your download limit when trying to download chapter 8, you should get this message:

    Download limit reached. When ready, rerun this command with the extra argument:
    ch08

Next you would either wait until the next day or change IP address, such as with a VPN, and run the command:

    ./DynastyScans.sh yurucamp ch09

Once completed, you can read the manga as images or use a tool such as [Kindle Comic Converter](https://kcc.iosphe.re/) to read on a Kindle.
