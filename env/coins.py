


class Berycoin(Coin):
    NAME = "Berycoin"
    SHORTNAME = "BERY"
    NET = "mainnet"
    XPUB_VERBYTES = bytes.fromhex("0586c22e")
    XPRV_VERBYTES = bytes.fromhex("0586dcf1")
    P2PKH_VERBYTE = bytes.fromhex("19")
    P2SH_VERBYTES = [bytes.fromhex("33"), bytes.fromhex("14")]
    WIF_BYTE = bytes.fromhex("d8")
    GENESIS_HASH = ('ff23a3590cc6e308f1817283cfa80779'
                    '3aae41d6a1de9f30ed15b7e8361d7005')
    DESERIALIZER = lib_tx.DeserializerSegWit
    DAEMON = daemon.LegacyRPCDaemon
    TX_COUNT = 26906
    TX_COUNT_HEIGHT = 24916
    TX_PER_BLOCK = 10
    RPC_PORT = 9432
    REORG_LIMIT = 800
    HEADER_HASH = None
    PEERS = [
        'electrum.berycoin.com s t',
        'electrum.resteemexposure.com s t',
        'electrum2.berycoin.com s t',        
    ]

    @classmethod
    def header_hash(cls, header):
        '''Given a header return the hash.'''
        if cls.HEADER_HASH is None:
            import scrypt
            cls.HEADER_HASH = lambda x: scrypt.hash(x, x, 1024, 1, 1, 32)

        version, = struct.unpack('<I', header[:4])
        if version > 6:
            return super().header_hash(header)
        else:
            return cls.HEADER_HASH(header);


