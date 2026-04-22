const { chromium } = require("playwright");
const path = require("path");
const fs = require("fs");

const APP_URL = process.env.APP_URL || "http://localhost:3839";
const VIDEOS_DIR = path.join(__dirname, "..", "videos");
const OUT_PATH = path.join(VIDEOS_DIR, "demo.webm");

const sleep = (ms) => new Promise((r) => setTimeout(r, ms));

async function waitForShiny(page) {
  await page.waitForFunction(
    () =>
      window.Shiny &&
      window.Shiny.shinyapp &&
      window.Shiny.shinyapp.isConnected(),
    { timeout: 30_000 }
  );
}

(async () => {
  fs.mkdirSync(VIDEOS_DIR, { recursive: true });

  const browser = await chromium.launch({ headless: true });
  const context = await browser.newContext({
    recordVideo: { dir: VIDEOS_DIR, size: { width: 960, height: 640 } },
    viewport: { width: 960, height: 640 },
  });

  const page = await context.newPage();

  console.log(`Connecting to ${APP_URL} ...`);
  await page.goto(APP_URL);
  await waitForShiny(page);
  await sleep(800);

  const input = page.locator("#city .aa-Input");
  await input.waitFor({ state: "visible" });
  await input.click();
  await sleep(400);

  // Type "B" — shows Berlin, Boston, Barcelona, ...
  await input.pressSequentially("B", { delay: 180 });
  await page.locator(".aa-Panel").waitFor({ state: "visible" });
  await sleep(900);

  // Narrow to "Ber" — only Berlin remains
  await input.pressSequentially("er", { delay: 160 });
  await sleep(900);

  // Arrow down to highlight Berlin, then confirm
  await page.keyboard.press("ArrowDown");
  await sleep(400);
  await page.keyboard.press("Enter");
  await sleep(1200);

  // Clear and type "Par" — Paris
  await input.click({ clickCount: 3 });
  await page.keyboard.press("Backspace");
  await sleep(400);

  await input.pressSequentially("Par", { delay: 160 });
  await page.locator(".aa-Panel").waitFor({ state: "visible" });
  await sleep(900);

  await page.keyboard.press("ArrowDown");
  await sleep(400);
  await page.keyboard.press("Enter");
  await sleep(1200);

  // Grab path before context closes (file completes on close)
  const videoPath = await page.video().path();

  await context.close();
  await browser.close();

  if (fs.existsSync(OUT_PATH)) fs.unlinkSync(OUT_PATH);
  fs.renameSync(videoPath, OUT_PATH);

  console.log(`Saved: ${OUT_PATH}`);
})().catch((err) => {
  console.error(err);
  process.exit(1);
});
