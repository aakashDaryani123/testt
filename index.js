const puppeteer = require("puppeteer");
const express = require("express");
const app = express();
require("dotenv").config();

const scrapeLogic = async (res) => {
  const browser = await puppeteer.launch({
    headless: true,
    args: [  "--disable-setuid-sandbox",
      "--no-sandbox",
      "--single-process",
      "--no-zygote",],
    executablePath:
      process.env.NODE_ENV === "production"
        ? process.env.PUPPETEER_EXECUTABLE_PATH
        : puppeteer.executablePath(),
  });

  try {
    const page = await browser.newPage();
    await page.goto("https://example.com");
    const text = await page.$eval("h1", (el) => el.textContent);
    res.send(text);
  } catch (err) {
    res.status(500).send("Error during scraping.");
    console.error(err);
  } finally {
    await browser.close();
  }
};

app.get("/", async (req, res) => {
  await scrapeLogic(res);
});

app.listen(process.env.PORT || 3000, () => {
  console.log("starting1234....");
  console.log(process.env.NODE_ENV);
  console.log(puppeteer.executablePath());
});
