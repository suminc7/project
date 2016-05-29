using UnityEngine;
using System.Collections;

[RequireComponent(typeof(AudioSource))]
public class MushroomMonster : MonoBehaviour {

	CharacterController CharControl;
	Animator animator;
	FirstPersonControl Player;
	SponMonsters sponObj;
	private AudioSource audio;

	public int monsterLife = 2;
	public AudioClip hitSound;
	public AudioClip dieSound;
	public AudioClip attack1Sound;
	public AudioClip attack2Sound;
	
	public GameObject face;
	public Damage damageObj;
	public GameObject bossItem;

	public Texture defaultTex;
	public Texture attackTex;
	public Texture hitTex;
	public GameObject hitEye;

	public static string KingName = "mushroomKing";
	public float dist = 2.5f;

	private Renderer faceRenderer;

	private bool isMoving = false;
	private bool isHit = false;
	private bool isDelay = false;
	private bool isDie = false;



	void Start () {
		CharControl = GetComponent<CharacterController> ();
		animator = GetComponent<Animator> ();
		Player = GameObject.Find ("First Person Controller").GetComponent<FirstPersonControl> ();
		audio = GetComponent<AudioSource> ();
		faceRenderer = face.GetComponent<Renderer> ();

		if (hitEye) {
			LeanTween.alpha (hitEye, 0, 0.01f);
			hitEye.gameObject.SetActive(true);

		}


	}


	// Update is called once per frame
	void Update () {

		if (isDie) {
			return;
		}

		if (isHit) {
			return;
		}

		if (isMoving) {

			Vector3 moveDirection = transform.forward;
			
			if (!CharControl.isGrounded) {
				moveDirection.y -= 20f * Time.deltaTime;
			}

			Vector3 pos = Player.transform.position;
			float currentDist = Vector3.Distance(pos, transform.position);
			//Debug.Log(currentDist);

			if(currentDist < dist){
				moveDirection = new Vector3(0,0,0);
				if(!animator.GetBool("Attack")){
					animator.SetBool("Attack", true);
				}

				if(FirstPersonControl.VR){
					Player.AttackVR();
				}


			}else{
				if(animator.GetBool("Attack")){
					animator.SetBool("Hit", false);
					animator.SetBool("Attack", false);
				}else{

				}


			}
			pos.y = transform.position.y;
			CharControl.Move (moveDirection * Time.deltaTime * 1.3f);


			Quaternion rotation = Quaternion.LookRotation(Player.transform.position - transform.position);
			rotation.x = rotation.z = 0;
			transform.rotation = Quaternion.Slerp(transform.rotation, rotation, Time.deltaTime * 3f);
		
		}

	}

	void FadeComplete(){
		Destroy (gameObject);
	}

	void Fade() {
		//LeanTween.moveY (gameObject, 0, 5.0f).setOnComplete (FadeComplete).setDelay (2f);
		LeanTween.scale (gameObject, new Vector3(0,0,0), 1.0f) .setEase( LeanTweenType.easeInCubic ).setOnComplete (FadeComplete).setDelay (2f);
	}
	
	IEnumerator PlayHitSound(float waitTime){
		yield return new WaitForSeconds(waitTime);
		audio.PlayOneShot (hitSound);
	}

	IEnumerator PlayDieSound(float waitTime){
		yield return new WaitForSeconds(waitTime);
		audio.PlayOneShot (dieSound);
	}

	void Die(){
		isDie = true;
		isMoving = false;
		animator.SetBool("Attack", false);
		animator.SetBool("Die", true);


		sponObj.DieMonster (gameObject.name);

		StartCoroutine (PlayDieSound(0.3f));

		if (gameObject.name == KingName) {
			Finished finished = GameObject.Find ("Finished").GetComponent<Finished> ();
			finished.SetActive ();
		}

		faceRenderer.material.SetTexture ("_MainTex", hitTex);

		Fade();
	}

	IEnumerator MoveAtSpeedCoroutine(Vector3 end, float speed){
		isHit = true;


		while (Vector3.Distance(this.transform.position,end) > speed*Time.deltaTime){
			this.transform.position = Vector3.MoveTowards(this.transform.position, end, speed*Time.deltaTime);
			yield return 0;
		}
		faceRenderer.material.SetTexture ("_MainTex", attackTex);
		isHit = false;
		this.transform.position = end;
	}

	IEnumerator HitDelay(float waitTime) {
		yield return new WaitForSeconds(waitTime);


		isDelay = false;
	}

	void CreateDamage(){
		Quaternion rot = transform.rotation;
		Vector3 pos = transform.position;

		pos.y += GetComponent<Collider>().bounds.size.y * 1.2f;
		//pos.z += 0.1f;
		StartCoroutine (CreateDamageDelay(0.0f , pos, 10));

		if (gameObject.name == KingName) {
			pos.y += 1.5f;
			StartCoroutine (CreateDamageDelay(0.2f , pos, 20));
			pos.y += 1.5f;
			StartCoroutine (CreateDamageDelay(0.4f , pos, 30));
		}

	}

	IEnumerator CreateDamageDelay(float waitTime, Vector3 pos, int depth) {
		yield return new WaitForSeconds(waitTime);
		Damage damage = Instantiate (damageObj, pos, transform.rotation) as Damage;
		//damage.transform.position = pos;
		//damage.transform.LookAt (Player.gameObject.transform.position);

		int len;
		float rndNum = 0f;
		if (gameObject.name == KingName) {
			len = 5;
			rndNum = Random.Range (10000, 20000);

		} else {
			len = 3;
			rndNum = Random.Range (100, 200);
		}

		damage.SetNumber (Player.gameObject, depth, len, rndNum);

		if (len == 5) {
			damage.transform.localScale = new Vector3(3,3,3);
		}
	}



	public void Hit(){
		if (isDie) {
			return;
		}

		if (isDelay) {
			return;
		}
		isDelay = true;
		StartCoroutine (HitDelay(0.5f));



		faceRenderer.material.SetTexture ("_MainTex", hitTex);

		CreateDamage ();
		
		monsterLife--;
		if (monsterLife > 0) {
			//StartCoroutine (PlayHitSound(0.3f));

			Vector3 forward = transform.forward;
			Vector3 pos = transform.position + transform.forward * -1.5f;
			StartCoroutine (MoveAtSpeedCoroutine (pos, 4f));
			Debug.Log ("MonsterHit");


		}

		if(monsterLife == 0) {
			Die ();
		}
		
		return;
		
	}

	public void Moving(SponMonsters spon){
		sponObj = spon; 
		//gameObject.SetActive (true);
		//animator.SetBool("Move", true);
		isMoving = true;

		face.GetComponent<AnimateTiledTexture> ().enabled = true;

	}

	/*
	 * animation event of king and monster
	 */


	void AnimBossDieEnd(){

		Vector3 pos = transform.position;
		pos.y += 0.5f;
		pos.z -= 0.5f;
		Instantiate (bossItem, pos, transform.rotation);
	}

	void AttackStart(){

		if (hitEye) {
			hitEye.gameObject.SetActive(true);

			LeanTween.alpha (hitEye, 0.5f, 0.15f) .setEase (LeanTweenType.easeInQuad);
			LeanTween.alpha (hitEye, 0f, 0.2f) .setEase (LeanTweenType.easeOutQuad).setDelay(0.15f).setOnComplete(HitEyeAlphaComplete);
			LeanTween.moveLocalZ (Player.leapOVR, Random.Range(1,4)*0.1f, 0.1f) .setEase (LeanTweenType.easeInQuad);
			LeanTween.moveLocalZ (Player.leapOVR, 0f, 0.15f) .setEase (LeanTweenType.easeInQuad).setDelay(0.1f);
		}



		faceRenderer.material.SetTexture ("_MainTex", attackTex);
		//jump
		int rnd1 = Random.Range(0, 4);
		if(rnd1 == 0){
			animator.SetTrigger("Jump");
		}

		if (gameObject.name == KingName) {
			float rnd = Random.Range(0,2);
			Debug.Log(rnd);
			if(rnd == 0){
				audio.PlayOneShot(attack1Sound);
			}else{
				audio.PlayOneShot(attack2Sound);
			}

		}
	}

	void HitEyeAlphaComplete(){
		hitEye.gameObject.SetActive(false);
	}
	
}
