//
//  Env.swift
//  BandeAnnonce
//
//  Created by  on 05/03/2020.
//  Copyright © 2020 Anthony chaussin. All rights reserved.
//

import Foundation

struct Env {
    static let token: String = "7a4d84070c59990cc8b793dc92c83bd2"
    static let prod: Bool = true
    static let bddName: [String] = ["Avatar", "Alita", "The Spook", "The Purge", "WATCHMEN"]
    static let bddResum: [String] = [
        "Jake Sully est recruté pour faire partie du programme Avatar car il possède le même génotype que son frère jumeau, un scientifique participant au programme retenu après une longue formation mais qui vient d'être assassiné par un voleur. En effet chaque « avatar » est créé génétiquement à partir d’ADN de Na’vi et de l’ADN de son « pilote ». Cela donne un être possédant un corps Na’vi et un cerveau humain, contrôlable à distance par l'équipe scientifique grâce à des ordinateurs. Un avatar qui n’est pas relié à un pilote est dans le coma et quand un pilote est connecté à un avatar dans un caisson spécial, son corps est comme endormi. Plusieurs humains participent au programme et ont donc un avatar, dont le docteur Grace Augustine qui est responsable scientifique et Norman Spellman spécialiste de la langue Na’vi, débarqué en même temps que Sully. Jake, dont les jambes sont paralysées, prend donc le contrôle de son avatar et découvre la joie de pouvoir marcher à nouveau.",
        "Lorsqu’Alita se réveille sans aucun souvenir de qui elle est, dans un futur qu’elle ne reconnaît pas, elle est accueillie par Ido, un médecin qui comprend que derrière ce corps de cyborg abandonné, se cache une jeune femme au passé extraordinaire. Ce n’est que lorsque les forces dangereuses et corrompues qui gèrent la ville d’Iron City se lancent à sa poursuite qu’Alita découvre la clé de son passé - elle a des capacités de combat uniques, que ceux qui détiennent le pouvoir veulent absolument maîtriser. Si elle réussit à leur échapper, elle pourrait sauver ses amis, sa famille, et le monde qu’elle a appris à aimer.",
        "Film indépendant, tourné sans aucune autorisation, racontant l'histoire d'un Noir américain qui s'enrôle à la CIA pour y apprendre les techniques de la guérilla et les transmettre à la communauté noire afin de faire exploser la révolution sur le territoire américain.",
        "La population se prépare à la nuit cauchemardesque instituée par le gouvernement pour faire face à la criminalité. Durant une période de 12 heures, une fois par an, les citoyens peuvent se livrer à tous les crimes, même au meurtre, sans craindre une intervention de la police ou une quelconque poursuite. Bourreau ou victime ? Chacun doit faire son choix...",
        "Aventure à la fois complexe et mystérieuse sur plusieurs niveaux, 'Watchmen - Les Gardiens' - se passe dans une Amérique alternative de 1985 où les super-héros font partie du quotidien et où l'Horloge de l'Apocalypse -symbole de la tension entre les Etats-Unis et l'Union Soviétique- indique en permanence minuit moins cinq. Lorsque l'un de ses anciens collègues est assassiné, Rorschach, un justicier masqué un peu à plat mais non moins déterminé, va découvrir un complot qui menace de tuer et de discréditer tous les super-héros du passé et du présent. Alors qu'il reprend contact avec son ancienne légion de justiciers -un groupe hétéroclite de super-héros retraités, seul l'un d'entre-eux possède de véritables pouvoirs- Rorschach entrevoit un complot inquiétant et de grande envergure lié à leur passé commun et qui aura des conséquences catastrophiques pour le futur. Leur mission est de protéger l'humanité... Mais qui veille sur ces gardiens ?"]
    static let bddCat: [String] = ["Drama", "Horreur", "Trailer", "Policier", "Romantique", "Comedie",
                            "Anime", "Famille", "Humour", "Serie", "Manga", "Théatre", "Indépendant"]
    static let genreCellReuseId: String = "GenreCell"
    static let movieCellReuseId: String = "CustCell"
}
