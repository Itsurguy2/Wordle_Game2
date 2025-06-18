//
//  WordGenerator.swift
//  Wordle_Game
//
//  Created by Jesse Rosenthal on 6/15/25.
//

import Foundation
import SwiftUI

class WordGenerator {
    private let standardWords = [
        "ABOUT", "ABOVE", "ABUSE", "ACTOR", "ACUTE", "ADMIT", "ADOPT", "ADULT", "AFTER", "AGAIN",
        "AGENT", "AGREE", "AHEAD", "ALARM", "ALBUM", "ALERT", "ALIEN", "ALIGN", "ALIKE", "ALIVE",
        "ALLOW", "ALONE", "ALONG", "ALTER", "AMONG", "ANGER", "ANGLE", "ANGRY", "APART", "APPLE",
        "APPLY", "ARENA", "ARGUE", "ARISE", "ARMED", "ARMOR", "ARRAY", "ARROW", "ASIDE", "ASSET",
        "AVOID", "AWAKE", "AWARD", "AWARE", "BADLY", "BAKER", "BASES", "BASIC", "BEACH", "BEGAN",
        "BEGIN", "BEING", "BELOW", "BENCH", "BILLY", "BIRTH", "BLACK", "BLADE", "BLAME", "BLANK",
        "BLAST", "BLIND", "BLOCK", "BLOOD", "BOARD", "BOAST", "BONUS", "BOOST", "BOOTH", "BOUND",
        "BRAIN", "BRAND", "BRASS", "BRAVE", "BREAD", "BREAK", "BREED", "BRICK", "BRIDE", "BRIEF",
        "BRING", "BROAD", "BROKE", "BROWN", "BUILD", "BUILT", "BUYER", "CABLE", "CALIF", "CARRY",
        "CATCH", "CAUSE", "CHAIN", "CHAIR", "CHAOS", "CHARM", "CHART", "CHASE", "CHEAP", "CHECK",
        "CHEST", "CHIEF", "CHILD", "CHINA", "CHOSE", "CIVIL", "CLAIM", "CLASS", "CLEAN", "CLEAR",
        "CLICK", "CLIMB", "CLOCK", "CLOSE", "CLOUD", "COACH", "COAST", "COULD", "COUNT", "COURT",
        "COVER", "CRAFT", "CRASH", "CRAZY", "CREAM", "CRIME", "CROSS", "CROWD", "CROWN", "CRUDE",
        "CURVE", "CYCLE", "DAILY", "DANCE", "DATED", "DEALT", "DEATH", "DEBUT", "DELAY", "DEPTH",
        "DOING", "DOUBT", "DOZEN", "DRAFT", "DRAMA", "DRANK", "DRAWN", "DREAM", "DRESS", "DRILL",
        "DRINK", "DRIVE", "DROVE", "DYING", "EAGER", "EARLY", "EARTH", "EIGHT", "ELITE", "EMPTY",
        "ENEMY", "ENJOY", "ENTER", "ENTRY", "EQUAL", "ERROR", "EVENT", "EVERY", "EXACT", "EXIST",
        "EXTRA", "FAITH", "FALSE", "FAULT", "FIBER", "FIELD", "FIFTH", "FIFTY", "FIGHT", "FINAL",
        "FIRST", "FIXED", "FLASH", "FLEET", "FLOOR", "FLUID", "FOCUS", "FORCE", "FORTH", "FORTY",
        "FORUM", "FOUND", "FRAME", "FRANK", "FRAUD", "FRESH", "FRONT", "FROST", "FRUIT", "FULLY",
        "FUNNY", "GIANT", "GIVEN", "GLASS", "GLOBE", "GOING", "GRACE", "GRADE", "GRAND", "GRANT",
        "GRASS", "GRAVE", "GREAT", "GREEN", "GROSS", "GROUP", "GROWN", "GUARD", "GUESS", "GUEST",
        "GUIDE", "HAPPY", "HARSH", "HATED", "HEARD", "HEART", "HEAVY", "HENCE", "HENRY", "HORSE",
        "HOTEL", "HOUSE", "HUMAN", "IDEAL", "IMAGE", "INDEX", "INNER", "INPUT", "ISSUE", "JAPAN",
        "JIMMY", "JOINT", "JONES", "JUDGE", "KNOWN", "LABEL", "LARGE", "LASER", "LATER", "LAUGH",
        "LAYER", "LEARN", "LEASE", "LEAST", "LEAVE", "LEGAL", "LEVEL", "LEWIS", "LIGHT", "LIMIT",
        "LINKS", "LIVES", "LOCAL", "LOOSE", "LOWER", "LUCKY", "LUNCH", "LYING", "MAGIC", "MAJOR",
        "MAKER", "MARCH", "MARIA", "MATCH", "MAYBE", "MAYOR", "MEANT", "MEDIA", "METAL", "MIGHT",
        "MINOR", "MINUS", "MIXED", "MODEL", "MONEY", "MONTH", "MORAL", "MOTOR", "MOUNT", "MOUSE",
        "MOUTH", "MOVED", "MOVIE", "MUSIC", "NEEDS", "NEVER", "NEWLY", "NIGHT", "NOISE", "NORTH",
        "NOTED", "NOVEL", "NURSE", "OCCUR", "OCEAN", "OFFER", "OFTEN", "ORDER", "OTHER", "OUGHT",
        "PAINT", "PANEL", "PAPER", "PARTY", "PEACE", "PETER", "PHASE", "PHONE", "PHOTO", "PIANO",
        "PIECE", "PILOT", "PITCH", "PLACE", "PLAIN", "PLANE", "PLANT", "PLATE", "POINT", "POUND",
        "POWER", "PRESS", "PRICE", "PRIDE", "PRIME", "PRINT", "PRIOR", "PRIZE", "PROOF", "PROUD",
        "PROVE", "QUEEN", "QUICK", "QUIET", "QUITE", "RADIO", "RAISE", "RANGE", "RAPID", "RATIO",
        "REACH", "READY", "REALM", "REBEL", "REFER", "RELAX", "REPAY", "REPLY", "RIGHT", "RIGID",
        "RIVAL", "RIVER", "ROBIN", "ROGER", "ROMAN", "ROUGH", "ROUND", "ROUTE", "ROYAL", "RURAL",
        "SCALE", "SCENE", "SCOPE", "SCORE", "SENSE", "SERVE", "SETUP", "SEVEN", "SHALL", "SHAPE",
        "SHARE", "SHARP", "SHEET", "SHELF", "SHELL", "SHIFT", "SHINE", "SHIRT", "SHOCK", "SHOOT",
        "SHORT", "SHOWN", "SIDES", "SIGHT", "SIGNS", "SILLY", "SINCE", "SIXTH", "SIXTY", "SIZED",
        "SKILL", "SLEEP", "SLIDE", "SMALL", "SMART", "SMILE", "SMITH", "SMOKE", "SOLID", "SOLVE",
        "SORRY", "SOUND", "SOUTH", "SPACE", "SPARE", "SPEAK", "SPEED", "SPEND", "SPENT", "SPLIT",
        "SPOKE", "SPORT", "STAFF", "STAGE", "STAKE", "STAND", "START", "STATE", "STEAM", "STEEL",
        "STICK", "STILL", "STOCK", "STONE", "STOOD", "STORE", "STORM", "STORY", "STRIP", "STUCK",
        "STUDY", "STUFF", "STYLE", "SUGAR", "SUITE", "SUPER", "SWEET", "TABLE", "TAKEN", "TASTE",
        "TAXES", "TEACH", "TEAMS", "TEETH", "TERRY", "TEXAS", "THANK", "THEFT", "THEIR", "THEME",
        "THERE", "THESE", "THICK", "THING", "THINK", "THIRD", "THOSE", "THREE", "THREW", "THROW",
        "THUMB", "TIGER", "TIGHT", "TIMES", "TIRED", "TITLE", "TODAY", "TOPIC", "TOTAL", "TOUCH",
        "TOUGH", "TOWER", "TRACK", "TRADE", "TRAIL", "TRAIN", "TRAIT", "TRASH", "TREAT", "TREND",
        "TRIAL", "TRIBE", "TRICK", "TRIED", "TRIES", "TRUCK", "TRULY", "TRUNK", "TRUST", "TRUTH",
        "TWICE", "UNCLE", "UNDER", "UNDUE", "UNION", "UNITY", "UNTIL", "UPPER", "UPSET", "URBAN",
        "USAGE", "USUAL", "VALID", "VALUE", "VIDEO", "VIRUS", "VISIT", "VITAL", "VOCAL", "VOICE",
        "WASTE", "WATCH", "WATER", "WHEEL", "WHERE", "WHICH", "WHILE", "WHITE", "WHOLE", "WHOSE",
        "WOMAN", "WOMEN", "WORLD", "WORRY", "WORSE", "WORST", "WORTH", "WOULD", "WRITE", "WRONG",
        "WROTE", "YOUNG", "YOUTH", "ZEBRA"
    ]
    
    private let animalWords = [
        "BEAR", "BIRD", "BULL", "CALF", "DEER", "DUCK", "FISH", "FROG", "GOAT", "HAWK",
        "LION", "LYNX", "MICE", "MOLE", "PONY", "SEAL", "SWAN", "TOAD", "WOLF", "WORM",
        "BEARS", "BIRDS", "BULLS", "CALFS", "DEERS", "DUCKS", "FISHS", "FROGS", "GOATS", "HAWKS",
        "LIONS", "MOUSE", "PANDA", "SHARK", "SHEEP", "SNAIL", "SNAKE", "TIGER", "WHALE", "ZEBRA"
    ]
    
    private let colorWords = [
        "BLUE", "CYAN", "GOLD", "GRAY", "PINK", "TEAL", "AQUA", "LIME", "NAVY", "RUBY",
        "BLACK", "BROWN", "CORAL", "GREEN", "IVORY", "KHAKI", "LEMON", "MAROON", "OLIVE", "PEACH",
        "PURPLE", "SILVER", "VIOLET", "WHITE", "YELLOW", "ORANGE", "INDIGO", "SALMON", "BRONZE", "ROUGE"
    ]
    
    private let countryWords = [
        "CHILE", "CHINA", "EGYPT", "GHANA", "HAITI", "INDIA", "ITALY", "JAPAN", "KENYA", "LIBYA",
        "MALTA", "NEPAL", "NIGER", "OMAN", "QATAR", "SAMOA", "SPAIN", "SUDAN", "SYRIA", "TONGA",
        "BRAZIL", "CANADA", "FRANCE", "GREECE", "ISRAEL", "JORDAN", "KUWAIT", "LATVIA", "MEXICO", "NORWAY",
        "POLAND", "RUSSIA", "SWEDEN", "TURKEY", "UGANDA", "UKRAINE", "CYPRUS", "ANGOLA", "BELIZE", "BHUTAN"
    ]
    
    private let foodWords = [
        "APPLE", "BACON", "BREAD", "CANDY", "CREAM", "DONUT", "FRIES", "GRAPE", "HONEY", "JELLY",
        "LEMON", "MANGO", "NOODLE", "OLIVE", "PASTA", "PIZZA", "SALAD", "TACO", "WAFFLE", "YOGURT",
        "BAGEL", "BERRY", "CEREAL", "CHEESE", "COOKIE", "CURRY", "FRUIT", "GRAVY", "JUICE", "KEBAB",
        "MAPLE", "ONION", "PEACH", "PRUNE", "SAUCE", "SPICE", "SYRUP", "TOAST", "TRUFFLE", "VANILLA"
    ]
    
    func getRandomWord(theme: WordTheme = .standard, length: Int = 5) -> String {
        let wordList = getWordList(for: theme)
        let filteredWords = wordList.filter { $0.count == length }
        
        if filteredWords.isEmpty {
            // Fallback to standard words if no words of desired length in theme
            let fallbackWords = standardWords.filter { $0.count == length }
            return fallbackWords.randomElement() ?? generateRandomWord(length: length)
        }
        
        return filteredWords.randomElement() ?? generateRandomWord(length: length)
    }
    
    private func getWordList(for theme: WordTheme) -> [String] {
        switch theme {
        case .standard:
            return standardWords
        case .animals:
            return animalWords
        case .colors:
            return colorWords
        case .countries:
            return countryWords
        case .food:
            return foodWords
        }
    }
    
    private func generateRandomWord(length: Int) -> String {
        let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        return String((0..<length).map { _ in letters.randomElement()! })
    }
}
