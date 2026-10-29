import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import test from "node:test";

const projectRoot = new URL("../", import.meta.url);

async function readProjectFile(path) {
  return readFile(new URL(path, projectRoot), "utf8");
}

for (const configName of ["config.json", "config.example.json"]) {
  test(`${configName} je ispravan razvojni open.mp konfiguracijski fajl`, async () => {
    const config = JSON.parse(await readProjectFile(configName));

    assert.equal(config.name, "Balkan Country RP");
    assert.equal(config.language, "Bosanski");
    assert.equal(config.announce, false);
    assert.equal(config.network.port, 7777);
    assert.equal(config.game.mode, "Igranje uloga | Bosna i Hercegovina");
    assert.deepEqual(config.pawn.main_scripts, ["bcrp 1"]);
    assert.equal(config.rcon.enable, false);
    assert.deepEqual(config.pawn.legacy_plugins, []);
  });
}

test("Pawn GameMode ima stvarne početne i povezivačke callbackove", async () => {
  const source = await readProjectFile("gamemodes/bcrp.pwn");

  assert.match(source, /#include <a_samp>/);
  assert.match(source, /public OnGameModeInit\(\)/);
  assert.match(source, /public OnPlayerConnect\(playerid\)/);
  assert.match(source, /AddPlayerClass\(/);
  assert.match(source, /Igranje uloga \| Bosna i Hercegovina/);
  assert.match(source, /Dobro do\\x9Aao na Balkan Country RP!/);
  assert.doesNotMatch(source, /SendClientMessage\([^;]*success/i);
});
